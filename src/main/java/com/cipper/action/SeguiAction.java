package com.cipper.action;

import com.cipper.manager.FollowerManager;
import com.cipper.manager.LoginManager;
import com.cipper.model.Follower;
import com.cipper.model.Utente;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class SeguiAction extends ActionSupport{
	int idUtente, idAltro;
	Utente utente, altro;

	public int getIdUtente() {
		return idUtente;
	}
	public void setIdUtente(int idUtente) {
		this.idUtente = idUtente;
	}
	public int getIdAltro() {
		return idAltro;
	}
	public void setIdAltro(int idAltro) {
		this.idAltro = idAltro;
	}
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
	
	public String execute() {
		LoginManager lm 		= new LoginManager();
		FollowerManager fm 	= new FollowerManager();
		utente = lm.read(idUtente);
		altro  = lm.read(idAltro);
		
		Follower f = new Follower();
		f.setIdUtente(idUtente);
		f.setIdSeguito(idAltro);
		
		if(fm.presente(utente.getIdUtente(), altro.getIdUtente()))
			fm.delete(f);
		else
			fm.create(f);
		
		return SUCCESS;
	}
	
}
