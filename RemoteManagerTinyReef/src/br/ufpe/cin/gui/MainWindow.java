package br.ufpe.cin.gui;

import org.eclipse.swt.SWT;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.graphics.Rectangle;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Menu;
import org.eclipse.swt.widgets.MenuItem;
import org.eclipse.swt.widgets.Shell;

public class MainWindow {

	Display display = null;
	
	private Shell sShell = null;  //  @jve:decl-index=0:visual-constraint="10,10"
	private Menu menuBar = null;
	private TopComposite topComposite = null;
	private LeftComposite leftComposite = null;

	public MainWindow() {
		display = new Display();
		
		createSShell();
	}

	public void setText(String str) {
		leftComposite.setText(str);
	}
	
	public void show() {
		sShell.open();
	    while (!sShell.isDisposed()) {
	      if (!display.readAndDispatch())
	    	  display.sleep();
	    }
	    display.dispose();
	}
	
	
	/**
	 * This method initializes sShell
	 */
	private void createSShell() {
		sShell = new Shell();
		sShell.setText("Remote Manager - TinyReef");
		createTopComposite();
		createLeftComposite();
		sShell.setSize(new Point(483, 503));
		sShell.setLayout(null);
		menuBar = new Menu(sShell, SWT.BAR);
		MenuItem push = new MenuItem(menuBar, SWT.PUSH);
		push.setText("&File");
		MenuItem push1 = new MenuItem(menuBar, SWT.PUSH);
		push1.setText("Help");
		sShell.setMenuBar(menuBar);
	}

	/**
	 * This method initializes topComposite	
	 *
	 */
	private void createTopComposite() {
		topComposite = new TopComposite(sShell, SWT.NONE);
		topComposite.setBounds(new Rectangle(3, 4, 457, 62));
	}

	/**
	 * This method initializes leftComposite	
	 *
	 */
	private void createLeftComposite() {
		leftComposite = new LeftComposite(sShell, SWT.NONE);
		leftComposite.setBounds(new Rectangle(5, 68, 329, 374));
	}

}
