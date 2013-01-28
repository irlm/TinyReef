package br.ufpe.cin.mips.elf;

import java.io.IOException;

public class ELFException extends IOException {
	
	private static final long serialVersionUID = 3432163738227239512L;

	ELFException(String s) {
		super(s);
	}
}