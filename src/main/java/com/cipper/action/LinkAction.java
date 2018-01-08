package com.cipper.action;

import com.cipper.manager.LoginManager;
import com.cipper.model.Utente;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class LinkAction extends ActionSupport{
	Utente utente;

	public Utente getUtente() {
		return utente;
	}

	public void setUtente(Utente utente) {
		this.utente = utente;
	}
	
	public String execute() {
		LoginManager lm = new LoginManager();
		utente = lm.read(utente.getIdUtente());
		
		return SUCCESS;
	}
}
