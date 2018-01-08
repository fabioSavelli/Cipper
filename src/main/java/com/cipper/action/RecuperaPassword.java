package com.cipper.action;

import java.util.ArrayList;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.URLName;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.cipper.manager.LoginManager;
import com.cipper.model.Utente;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class RecuperaPassword  extends ActionSupport {
	private Utente recupera;
	private String errori;
	
	public Utente getRecupera() {
		return recupera;
	}
	public void setRecupera(Utente recupera) {
		this.recupera = recupera;
	}
	public String getErrori() {
		return errori;
	}
	public void setErrori(String errori) {
		this.errori = errori;
	}

	private void invioEmail() {
		// valori per invio email 
		final String host 		= "smtp.sincrono.it";
	    final String mittente 	= "corso.java@sincrono.it(Cipper)";
	    final String oggetto		= "Recupera password";
		final String user		= "corso.java@sincrono.it";
		final String psw 		= "c0rs0.java";
		final String dest = recupera.getEmail();

		// genero nuova password
		final String ALPHA_NUMERIC_STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
		StringBuilder builder = new StringBuilder();
		for ( int i = 0 ; i < 8 ; i++) {
			int character = (int)(Math.random()*ALPHA_NUMERIC_STRING.length());
			builder.append(ALPHA_NUMERIC_STRING.charAt(character));
		}
		String nuovaPsw = builder.toString();
		
		// modifico password nel DB
		LoginManager lm = new LoginManager();
		lm.modificaPassword(recupera, nuovaPsw);
		
		// testo dell'email
		String testo = "Il sistema ha provveduto a modificare la sua password.\n"
				+ "Accedi di nuovo a Cipper con le seguenti credenziali\n\n"
				+ "email: "+recupera.getEmail()+"\n"
				+ "password: "+nuovaPsw+"\n\n"
				+ "Lo staf di Cipper ti augura un buon preseguimento di giornata.";
		 
	    Properties p = System.getProperties();
		
		p.setProperty("mail.smtp.host", host);
	    p.put("mail.smtp.host", host);
	    p.put("mail.debug", "true");
	    p.put("mail.smtp.auth", "true"); 
	    
	    Session sessione = Session.getDefaultInstance(p, new SmtpAutenticazione(user, psw) );
	    sessione.setPasswordAuthentication(new URLName("smtp", host, 25, "INBOX", user, psw), new PasswordAuthentication(user, psw));

		MimeMessage mail = new MimeMessage(sessione);

	  	try {
	    	 	mail.setFrom(new InternetAddress(mittente));
	    	 	mail.addRecipients(Message.RecipientType.TO, dest);
   	 	
	    	 	mail.setSubject(oggetto);
	    	 	mail.setText(testo);

	    	 	Transport tr = sessione.getTransport("smtp");
	    		tr.connect(host, user, psw);
	    	 	Transport.send(mail, mail.getAllRecipients());
	    }
	  	catch(Exception e) {
   	 		e.printStackTrace();
	    }   
	}
	
	public void validate() {
		errori = "";
		boolean valido = true;
		if(recupera.getUsername().equals("")) {
			valido = false;
			addActionError("1"); //inserisci username
			errori += " 1";
		}
		if(recupera.getEmail().equals("")) {
			valido = false;
			addActionError("2"); //inserisci email
			errori += " 2";
		}
		
		if(valido) {
			LoginManager lm = new LoginManager();
			ArrayList<Utente> tutti = lm.allUtenti();
			
			for(int i=0; i<tutti.size(); i++) {
				Utente attuale = tutti.get(i);
				if (attuale.getEmail().equals(recupera.getEmail()) &&
					attuale.getUsername().equals(recupera.getUsername())){
					
					if(attuale.getAttivo().equals("SI")) {
						recupera = attuale;
						invioEmail();
						addActionMessage("l'email è stata inviata");
						return; // OK
					}
					else {
						addActionError("3"); //account eliminato
						errori += " 3";	
						return;
					}
				}
			}
			addActionError("4"); //credenziali non esistenti
			errori += " 4";
		}
	}
	
	public String execute() {
		return SUCCESS;
	}	
}