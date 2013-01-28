package br.ufpe.cin.mips.elf;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.RandomAccessFile;

public class PHeader {

	private ELFInputStream elfInputStream;

	private int type;
	private int offset;
	private int vaddr;
	private int paddr;
	private int filesz;
	private int memsz;
	private int flags;
	private int align;

	PHeader(RandomAccessFile randomAccessFile) throws IOException {

		this.type = randomAccessFile.readInt();
		this.offset = randomAccessFile.readInt();
		this.vaddr = randomAccessFile.readInt();
		this.paddr = randomAccessFile.readInt();
		this.filesz = randomAccessFile.readInt();
		this.memsz = randomAccessFile.readInt();
		this.flags = randomAccessFile.readInt();
		this.align = randomAccessFile.readInt();

		if (this.filesz > this.memsz)
			throw new ELFException("ELF inconsistency: filesz > memsz");
		
		this.elfInputStream = new ELFInputStream(randomAccessFile, this.offset, this.filesz);
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getOffset() {
		return offset;
	}

	public void setOffset(int offset) {
		this.offset = offset;
	}

	public int getVaddr() {
		return vaddr;
	}

	public void setVaddr(int vaddr) {
		this.vaddr = vaddr;
	}

	public int getPaddr() {
		return paddr;
	}

	public void setPaddr(int paddr) {
		this.paddr = paddr;
	}

	public int getFilesz() {
		return filesz;
	}

	public void setFilesz(int filesz) {
		this.filesz = filesz;
	}

	public int getMemsz() {
		return memsz;
	}

	public void setMemsz(int memsz) {
		this.memsz = memsz;
	}

	public int getFlags() {
		return flags;
	}

	public void setFlags(int flags) {
		this.flags = flags;
	}

	public int getAlign() {
		return align;
	}

	public void setAlign(int align) {
		this.align = align;
	}

	public InputStream getInputStream() throws IOException {
		return new BufferedInputStream(this.elfInputStream);
	}
	
	public ELFInputStream getELFInputStream() throws IOException {

		return this.elfInputStream;
	}
}