package com.cipper.action;

import java.util.Calendar;

import com.cipper.manager.CipManager;
import com.cipper.manager.LoginManager;
import com.cipper.model.Cip;
import com.cipper.model.Utente;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class NuovoCipAction extends ActionSupport{
	Utente utente;
	Cip nuovoCip;

	public Utente getUtente() {
		return utente;
	}
	public void setUtente(Utente utente) {
		this.utente = utente;
	}
	public Cip getNuovoCip() {
		return nuovoCip;
	}
	public void setNuovoCip(Cip nuovoCip) {
		this.nuovoCip = nuovoCip;
	}
	
	public void validate() {
		if(nuovoCip.getTesto().length()>150) {
			addFieldError("nuovoCip.testo", "testo troppo grande");
		}
		if(nuovoCip.getTesto().length()==0) {
			addFieldError("nuovoCip.testo", "inserire un testo");
		}
	}
	
	public String execute() {
		LoginManager lm = new LoginManager();
		utente = lm.read(utente.getIdUtente());
		
		Calendar data = Calendar.getInstance();
		
		nuovoCip.setData(data);
		nuovoCip.setIdAutore(utente.getIdUtente());
		nuovoCip.setLikes(0);
		nuovoCip.setShares(0);
		
		CipManager cm = new CipManager();
		cm.create(nuovoCip);
		
		return SUCCESS;
	}
}
