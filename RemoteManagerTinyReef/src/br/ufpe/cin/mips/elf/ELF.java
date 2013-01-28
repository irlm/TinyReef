package br.ufpe.cin.mips.elf;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.RandomAccessFile;

public class ELF {

	private RandomAccessFile randomAccessFile;

	private ELFHeader header;
	private PHeader[] pheaders;
	private SHeader[] sheaders;

	private byte[] stringTable;

	public ELF(String img) throws IOException, ELFException {

		randomAccessFile = new RandomAccessFile((String) img, "r");

		randomAccessFile.seek(0);

		header = new ELFHeader(randomAccessFile);

		pheaders = new PHeader[header.getPhnum()];
		for (int i = 0; i < header.getPhnum(); i++) {
			randomAccessFile
					.seek(header.getPhoff() + i * header.getPhentsize());
			pheaders[i] = new PHeader(randomAccessFile);
		}

		sheaders = new SHeader[header.getShnum()];
		for (int i = 0; i < header.getShnum(); i++) {
			randomAccessFile
					.seek(header.getShoff() + i * header.getShentsize());
			sheaders[i] = new SHeader(randomAccessFile);
		}

		if (header.getShstrndx() < 0
				|| header.getShstrndx() >= header.getShnum())
			throw new ELFException("Bad shstrndx");

		randomAccessFile.seek(sheaders[header.getShstrndx()].getOffset());

		stringTable = new byte[sheaders[header.getShstrndx()].getSize()];
		randomAccessFile.readFully(stringTable);

		for (int i = 0; i < header.getShnum(); i++) {
			SHeader s = sheaders[i];
			s.setName(getString(s.getNameidx()));
		}
	}

	public ELFHeader getHeader() {
		return header;
	}

	public PHeader[] getPheaders() {
		return pheaders;
	}

	public SHeader[] getSheaders() {
		return sheaders;
	}

	private String getString(int off) {
		return getString(off, stringTable);
	}

	private String getString(int off, byte[] strtab) {
		StringBuffer sb = new StringBuffer();
		while (off < strtab.length && strtab[off] != 0)
			sb.append((char) strtab[off++]);
		return sb.toString();
	}

	public SHeader sectionWithName(String name) {
		for (int i = 0; i < sheaders.length; i++)
			if (sheaders[i].getName().equals(name))
				return sheaders[i];
		return null;
	}

	private Symtab _symtab;

	public Symtab getSymtab() throws IOException {
		if (_symtab != null)
			return _symtab;

		SHeader sh = sectionWithName(".symtab");
		if (sh == null || sh.getType() != SHeader.SHT_SYMTAB)
			return null;

		SHeader sth = sectionWithName(".strtab");
		if (sth == null || sth.getType() != SHeader.SHT_STRTAB)
			return null;

		byte[] strtab = new byte[sth.getSize()];
		DataInputStream dis = new DataInputStream(sth.getInputStream());
		dis.readFully(strtab);
		dis.close();

		return _symtab = new Symtab(sh.getInputStream(), sh.getSize(), strtab);
	}

	public class Symtab {
		public Symbol[] symbols;

		Symtab(InputStream is, int size, byte[] strtab) throws IOException {
			DataInputStream dis = new DataInputStream(is);
			int count = size / 16;
			symbols = new Symbol[count];
			for (int i = 0; i < count; i++)
				symbols[i] = new Symbol(dis, strtab);
			dis.close();
		}
	}

	public class Symbol {
		public String name;
		public int addr;
		public int size;
		public byte info;
		public byte type;
		public byte other;
		public SHeader sheader;

		public final static int STT_FUNC = 2;

		Symbol(DataInputStream dis, byte[] strtab) throws IOException {
			name = getString(dis.readInt(), strtab);
			addr = dis.readInt();
			size = dis.readInt();
			info = dis.readByte();
			type = (byte) (info & 0xf);
			other = dis.readByte();
			// FIXME: Find sheader entry
			dis.readShort();
		}
	}

	private static String toHex(int n) {
		return "0x" + Long.toString(n & 0xffffffffL, 16);
	}

	// teste
	public static void main(String[] args) throws IOException {

		String img;
		
		/*/
		System.out.println("Blink Program");
		img  = "/home/igor/Mestrado/madapt-wssn/trunk/code/apps/TinyReefBlink/Debug/TinyReefCompilerTest";
		/*/
		//System.out.println("RadioCountToLeds Program\n");
	//	img  = "/home/igor/Mestrado/madapt-wssn/trunk/code/apps/TinyReefRadioCountToLeds/Debug/TinyReefCompilerTest";
		
		System.out.println("TinyReefTests Program\n");
		img  = "/home/igor/Mestrado/madapt-wssn/trunk/code/apps/TinyReefTests/Debug/TinyReefCompilerTest";
		//*/
		
		ELF elf = new ELF(img);

		System.out.println("Type: " + toHex(elf.header.getType()));
		System.out.println("Machine: " + toHex(elf.header.getMachine()));
		System.out.println("Entry: " + toHex(elf.header.getEntry()));
		for (int i = 0; i < elf.pheaders.length; i++) {
			PHeader ph = elf.pheaders[i];
			System.out.println("PHeader " + toHex(i));
			System.out.println("\tOffset: " + ph.getOffset());
			System.out.println("\tVaddr: " + toHex(ph.getVaddr()));
			System.out.println("\tFile Size: " + ph.getFilesz());
			System.out.println("\tMem Size: " + ph.getMemsz());
		}
		for (int i = 0; i < elf.sheaders.length; i++) {
			SHeader sh = elf.sheaders[i];
			System.out.println("SHeader " + toHex(i));
			System.out.println("\tName: " + sh.getName());
			System.out.println("\tOffset: " + sh.getOffset());
			System.out.println("\tAddr: " + toHex(sh.getAddr()));
			System.out.println("\tSize: " + sh.getSize());
			System.out.println("\tType: " + toHex(sh.getType()));
		}
		
		//Symtab symtab = elf.getSymtab();
	}
}
