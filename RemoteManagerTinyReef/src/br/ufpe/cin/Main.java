package br.ufpe.cin;

import java.io.IOException;

import br.ufpe.cin.gui.MainWindow;
import br.ufpe.cin.mips.elf.ELFException;
import br.ufpe.cin.tinyreef.ELFConverter;

public class Main {

	public static void main(String[] args) {
		
		ELFConverter converter = new ELFConverter();
		
		String img;
		
		System.out.println("TinyReefTests Program\n");
		img  = "/home/igor/Mestrado/madapt-wssn/trunk/code/apps/TinyReefTests/Debug/TinyReefCompilerTest";
		
		StringBuffer str = new StringBuffer("");
		
		try {
			converter.elfToTinyReefPacket((short) 0, img, str);
			
			MainWindow mainWindow = new MainWindow();
			mainWindow.setText(str.toString());
			mainWindow.show();
			
		} catch (ELFException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
