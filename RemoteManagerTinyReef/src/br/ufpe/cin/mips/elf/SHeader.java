package br.ufpe.cin.mips.elf;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.RandomAccessFile;

public class SHeader {

	private int nameidx;
	private String name;
	private int type;
	private int flags;
	private int addr;
	private int offset;
	private int size;
	private int link;
	private int info;
	private int addralign;
	private int entsize;

	public static final int SHT_SYMTAB = 2;
	public static final int SHT_STRTAB = 3;
	public static final int SHT_NOBITS = 8;

	private ELFInputStream elfInputStream;

	SHeader(RandomAccessFile randomAccessFile) throws IOException {

		this.nameidx = randomAccessFile.readInt();
		this.type = randomAccessFile.readInt();
		this.flags = randomAccessFile.readInt();
		this.addr = randomAccessFile.readInt();
		this.offset = randomAccessFile.readInt();
		this.size = randomAccessFile.readInt();
		this.link = randomAccessFile.readInt();
		this.info = randomAccessFile.readInt();
		this.addralign = randomAccessFile.readInt();
		this.entsize = randomAccessFile.readInt();

		this.elfInputStream = new ELFInputStream(randomAccessFile, offset, size);

	}

	public int getNameidx() {
		return nameidx;
	}

	public void setNameidx(int nameidx) {
		this.nameidx = nameidx;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getFlags() {
		return flags;
	}

	public void setFlags(int flags) {
		this.flags = flags;
	}

	public int getAddr() {
		return addr;
	}

	public void setAddr(int addr) {
		this.addr = addr;
	}

	public int getOffset() {
		return offset;
	}

	public void setOffset(int offset) {
		this.offset = offset;
	}

	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}

	public int getLink() {
		return link;
	}

	public void setLink(int link) {
		this.link = link;
	}

	public int getInfo() {
		return info;
	}

	public void setInfo(int info) {
		this.info = info;
	}

	public int getAddralign() {
		return addralign;
	}

	public void setAddralign(int addralign) {
		this.addralign = addralign;
	}

	public int getEntsize() {
		return entsize;
	}

	public void setEntsize(int entsize) {
		this.entsize = entsize;
	}

	public InputStream getInputStream() throws IOException {

		return new BufferedInputStream(this.elfInputStream);
	}
	
	public ELFInputStream getELFInputStream() throws IOException {

		return this.elfInputStream;
	}
}