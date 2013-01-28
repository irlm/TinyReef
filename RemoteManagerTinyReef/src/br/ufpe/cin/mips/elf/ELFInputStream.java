package br.ufpe.cin.mips.elf;

import java.io.IOException;
import java.io.InputStream;
import java.io.RandomAccessFile;

public class ELFInputStream extends InputStream {

	private byte[] bytes;

	private int length;

	private int pos;

	ELFInputStream(RandomAccessFile randomAccessFile, int start, int length)
			throws IOException {

		
		if ((start < length) || (randomAccessFile.length() > length)) {

			this.bytes = new byte[length + 1];
		    
			long pos = randomAccessFile.getFilePointer();
			
			randomAccessFile.seek(start);
			
	        // Read in the bytes
	        int offset = 0;
	        int numRead = 0;
	        while (offset < this.bytes.length
	               && (numRead = randomAccessFile.read(this.bytes, offset, this.bytes.length-offset)) >= 0) {
	            offset += numRead;
	        }

	        this.bytes[length] = 0;
        
			randomAccessFile.seek(pos);

			this.length = length;
		} else {
			this.length = 0;
		}

		this.pos = 0;

	}

	@Override
	public int read() throws IOException {

		int ret = -1;

		if (this.pos < length) {

			ret = this.bytes[this.pos];
			
			this.pos++;
		}

		return ret;
	}
	
	public int getLength() {
		return length;
	}

	public byte[] getBytes() {
		return bytes;
	}
}
