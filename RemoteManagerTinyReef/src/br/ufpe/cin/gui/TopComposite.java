package br.ufpe.cin.gui;

import org.eclipse.swt.SWT;
import org.eclipse.swt.custom.CLabel;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.graphics.Rectangle;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Text;

public class TopComposite extends Composite {

	private Button button = null;
	private CLabel cLabel1 = null;
	private Text text = null;

	public TopComposite(Composite parent, int style) {
		super(parent, style);
		initialize();
	}

	private void initialize() {
		button = new Button(this, SWT.NONE);
		button.setBounds(new Rectangle(364, 14, 86, 27));
		button.setText("disconnect");
		cLabel1 = new CLabel(this, SWT.NONE);
		cLabel1.setText("BaseStation:");
		cLabel1.setBounds(new Rectangle(15, 14, 88, 23));
		text = new Text(this, SWT.BORDER);
		text.setBounds(new Rectangle(115, 14, 231, 25));
		text.setEnabled(false);
		text.setText("/dev/ttyUSB1");
		setSize(new Point(475, 57));
		setLayout(null);
	}

}  //  @jve:decl-index=0:visual-constraint="48,0"
