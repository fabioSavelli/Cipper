package com.cipper.action;

import com.cipper.manager.CipManager;
import com.cipper.manager.LikesManager;
import com.cipper.manager.LoginManager;
import com.cipper.model.Cip;
import com.cipper.model.Likes;
import com.cipper.model.Utente;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class LikeAction extends ActionSupport{
	Utente utente;
	Cip cip;
	String dati;
	
	public Utente getUtente() {
		return utente;
	}
	public void setUtente(Utente utente) {
		this.utente = utente;
	}
	public Cip getCip() {
		return cip;
	}
	public void setCip(Cip cip) {
		this.cip = cip;
	}
	public String getDati() {
		return dati;
	}
	public void setDati(String dati) {
		this.dati = dati;
	}

	public void execute1() {
		LoginManager lm = new LoginManager();
		CipManager cm = new CipManager();
		
		utente = lm.read(Integer.parseInt(dati.split(" ")[0]));
		cip = cm.read(Integer.parseInt(dati.split(" ")[1]));
		
		Likes nuovo = new Likes();
		nuovo.setIdCip(cip.getIdCip());
		nuovo.setIdUtente(utente.getIdUtente());
		
		LikesManager lkm = new LikesManager();
	    lkm.create(nuovo);	
	}
}
