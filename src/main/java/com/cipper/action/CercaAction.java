package com.cipper.action;

import java.util.ArrayList;

import com.cipper.manager.LoginManager;
import com.cipper.model.Utente;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class CercaAction extends ActionSupport {
	Utente utente, altro;
	String usernameAltro;
	
	public Utente getUtente() {
		return utente;
	}
	public void setUtente(Utente utente) {
		this.utente = utente;
	}
	public Utente getAltro() {
		return altro;
	}
	public void setAltro(Utente altro) {
		this.altro = altro;
	}
	public String getUsernameAltro() {
		return usernameAltro;
	}
	public void setUsernameAltro(String usernameAltro) {
		this.usernameAltro = usernameAltro;
	}
	
	public void validate() {
		LoginManager lm = new LoginManager();
		utente = lm.read(utente.getIdUtente());
		
		if(usernameAltro.equals("")) {
			addActionError("");
			addActionMessage("inserire un utente da cercare");
		}
	}
	
	public String execute() {
		LoginManager lm = new LoginManager();
		ArrayList<Utente> tutti = lm.allUtenti();
		
		for(int i=0; i<tutti.size(); i++) {
			if(tutti.get(i).getUsername().equals(usernameAltro) && tutti.get(i).getAttivo().equals("SI")) {
				altro = lm.read(tutti.get(i).getIdUtente());
				return SUCCESS;
			}
		}
		addActionMessage("l'utente da te cercato non esiste");
		return "input";
	}
}
