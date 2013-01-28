package br.ufpe.cin.gui;

import org.eclipse.swt.SWT;
import org.eclipse.swt.custom.CCombo;
import org.eclipse.swt.custom.CLabel;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.graphics.Rectangle;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Text;
import org.eclipse.swt.widgets.Button;

public class LeftComposite extends Composite {

	final String[] options = { "Broadcast", "Node 1", "Node 2", "Node 3", "Node 4", "Node 5", "Node 6" };
	
	private CLabel cLabel = null;
	private CCombo cCombo = null;

	private CLabel cLabel1 = null;

	private Text text = null;

	private Button button = null;

	private CLabel cLabel2 = null;

	private Text textArea = null;

	private Button button1 = null;

	public LeftComposite(Composite parent, int style) {
		super(parent, style);
		initialize();
	}
	
	public void setText(String str) {
		textArea.setText(str);
	}

	private void initialize() {
		cLabel = new CLabel(this, SWT.NONE);
		cLabel.setText("Destiny:");
		cLabel.setBounds(new Rectangle(13, 16, 60, 23));
		cCombo = new CCombo(this, SWT.NONE);
		cCombo.setText("Broadcast");
		cCombo.setBounds(new Rectangle(90, 16, 210, 25));
		cLabel1 = new CLabel(this, SWT.NONE);
		cLabel1.setText("Program:");
		cLabel1.setBounds(new Rectangle(17, 61, 71, 23));
		text = new Text(this, SWT.BORDER);
		text.setBounds(new Rectangle(101, 65, 146, 25));
		text.setText("/home/igor/programs");
		button = new Button(this, SWT.NONE);
		button.setBounds(new Rectangle(259, 63, 50, 27));
		button.setText("Open");
		cLabel2 = new CLabel(this, SWT.NONE);
		cLabel2.setText("Source:");
		cLabel2.setBounds(new Rectangle(21, 111, 49, 23));
		textArea = new Text(this, SWT.MULTI | SWT.WRAP | SWT.V_SCROLL);
		textArea.setBounds(new Rectangle(24, 144, 278, 230));
		textArea.setText("");
		button1 = new Button(this, SWT.NONE);
		button1.setBounds(new Rectangle(254, 108, 54, 27));
		button1.setText("Send");
		
		this.setSize(new Point(317, 384));
		setLayout(null);
	}

}  //  @jve:decl-index=0:visual-constraint="23,23"
