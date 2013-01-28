package br.ufpe.cin.mips.elf;

import java.io.DataInput;
import java.io.IOException;

public class ELFHeader {
	
	private byte klass;
	private byte data;
	private byte osabi;
	private byte abiversion;

	private short type;
	private short machine;
	private int version;
	private int entry;
	private int phoff;
	private int shoff;
	private int flags;
	private short ehsize;
	private short phentsize;
	private short phnum;
	private short shentsize;
	private short shnum;
	private short shstrndx;

	private static final int ELF_MAGIC = 0x7f454c46; // '\177', 'E', 'L', 'F'

	ELFHeader(DataInput fd) throws IOException {
		
		if (fd.readInt() != ELF_MAGIC)
			throw new ELFException("Bad Magic (is: ");
		
		this.klass = fd.readByte();
		this.data = fd.readByte();
		
		fd.skipBytes(1); // version
		
		this.osabi = fd.readByte();
		this.abiversion = fd.readByte();
		
		fd.skipBytes(7);
		
		this.type = fd.readShort();
		this.machine = fd.readShort();
		this.version = fd.readInt();
		this.entry = fd.readInt();
		this.phoff = fd.readInt();
		this.shoff = fd.readInt();
		this.flags = fd.readInt();
		this.ehsize = fd.readShort();
		this.phentsize = fd.readShort();
		this.phnum = fd.readShort();
		this.shentsize = fd.readShort();
		this.shnum = fd.readShort();
		this.shstrndx = fd.readShort();
	}

	public byte getKlass() {
		return klass;
	}

	public void setKlass(byte klass) {
		this.klass = klass;
	}

	public byte getData() {
		return data;
	}

	public void setData(byte data) {
		this.data = data;
	}

	public byte getOsabi() {
		return osabi;
	}

	public void setOsabi(byte osabi) {
		this.osabi = osabi;
	}

	public byte getAbiversion() {
		return abiversion;
	}

	public void setAbiversion(byte abiversion) {
		this.abiversion = abiversion;
	}

	public short getType() {
		return type;
	}

	public void setType(short type) {
		this.type = type;
	}

	public short getMachine() {
		return machine;
	}

	public void setMachine(short machine) {
		this.machine = machine;
	}

	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	public int getEntry() {
		return entry;
	}

	public void setEntry(int entry) {
		this.entry = entry;
	}

	public int getPhoff() {
		return phoff;
	}

	public void setPhoff(int phoff) {
		this.phoff = phoff;
	}

	public int getShoff() {
		return shoff;
	}

	public void setShoff(int shoff) {
		this.shoff = shoff;
	}

	public int getFlags() {
		return flags;
	}

	public void setFlags(int flags) {
		this.flags = flags;
	}

	public short getEhsize() {
		return ehsize;
	}

	public void setEhsize(short ehsize) {
		this.ehsize = ehsize;
	}

	public short getPhentsize() {
		return phentsize;
	}

	public void setPhentsize(short phentsize) {
		this.phentsize = phentsize;
	}

	public short getPhnum() {
		return phnum;
	}

	public void setPhnum(short phnum) {
		this.phnum = phnum;
	}

	public short getShentsize() {
		return shentsize;
	}

	public void setShentsize(short shentsize) {
		this.shentsize = shentsize;
	}

	public short getShnum() {
		return shnum;
	}

	public void setShnum(short shnum) {
		this.shnum = shnum;
	}

	public short getShstrndx() {
		return shstrndx;
	}

	public void setShstrndx(short shstrndx) {
		this.shstrndx = shstrndx;
	}
	
}
