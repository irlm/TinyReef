package br.ufpe.cin.tinyreef;

import java.io.IOException;
import java.util.Vector;

import br.ufpe.cin.mips.elf.ELF;
import br.ufpe.cin.mips.elf.ELFConst;
import br.ufpe.cin.mips.elf.ELFException;
import br.ufpe.cin.mips.elf.SHeader;

public class ELFConverter {

	public TinyReefPacket elfToTinyReefPacket(short version, String file, StringBuffer result)
			throws ELFException, IOException {

		TinyReefPacket ret = new TinyReefPacket();

		Vector<Byte> tinyReefELF = new Vector<Byte>();
		
		ELF elf = new ELF(file);

		ret.set_head_version(version);

		int cont = 0;
		for (SHeader sHeader : elf.getSheaders()) {

			if (sHeader.getName().equalsIgnoreCase(ELFConst.TEXT) ||
				sHeader.getName().equalsIgnoreCase(ELFConst.DATA) ||
				sHeader.getName().equalsIgnoreCase(ELFConst.GOT) ||
				sHeader.getName().equalsIgnoreCase(ELFConst.SBSS)) {

				ret.dataSet(sHeader.getELFInputStream().getBytes());
				
				byte opa[] = sHeader.getELFInputStream().getBytes();
				
				for (int i = 0; i < sHeader.getELFInputStream().getLength(); i++) {
					
					tinyReefELF.add(opa[i]);
					
					cont++;
					
					System.out.print("0x" + Integer.toHexString( (0xFF & (opa[i]) + 0)) + ", ");
					
					if( (0xFF & (opa[i]) + 0) < 0xF) 
					{
						result.append("0");
					}
					
					result.append((Integer.toHexString( (0xFF & (opa[i]) + 0))).toUpperCase());
															
					
					if((i % 4) == 3)
					{
						System.out.println();
						result.append("\n");
					}
						
				}
				System.out.println();
			}
		}
		
		System.out.println(cont);

		return ret;
	}
}
