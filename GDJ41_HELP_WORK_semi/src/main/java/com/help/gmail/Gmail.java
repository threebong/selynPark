package com.help.gmail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Gmail extends Authenticator{

	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("helpwork2021help@gmail.com", "helphelp!1");
	}
	
	
	
}
