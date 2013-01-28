package br.ufpe.cin.tinyreef;

import java.io.IOException;

import br.ufpe.cin.mips.elf.ELFException;

public class Main {

	public static void main(String[] args) {
			
		ELFConverter converter = new ELFConverter();
		
		String img;
		
		/*/
			System.out.println("Blink Program");
			img  = "/home/igor/Mestrado/madapt-wssn/trunk/code/apps/TinyReefBlink/Debug/TinyReefCompilerTest";
		/*/
			//System.out.println("RadioCountToLeds Program\n");
			//img  = "/home/igor/Mestrado/madapt-wssn/trunk/code/apps/TinyReefRadioCountToLeds/Debug/TinyReefCompilerTest";
		
			//System.out.println("TinyReefRadioSenseToLeds Program\n");
			//img  = "/home/igor/Mestrado/madapt-wssn/trunk/code/apps/TinyReefRadioSenseToLeds/Debug/TinyReefCompilerTest";
		
			System.out.println("TinyReefTests Program\n");
			img  = "/home/igor/Mestrado/madapt-wssn/trunk/code/apps/TinyReefTests/Debug/TinyReefCompilerTest";
			
		//*/
		
		try {
			converter.elfToTinyReefPacket((short) 0, img, null);
		} catch (ELFException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
