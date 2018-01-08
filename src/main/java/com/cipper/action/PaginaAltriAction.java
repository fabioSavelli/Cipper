package com.cipper.action;

import com.cipper.manager.LoginManager;
import com.cipper.model.Utente;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class PaginaAltriAction extends ActionSupport{
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
		LoginManager lm = new LoginManager();
		utente = lm.read(idUtente);
		altro  = lm.read(idAltro);
		return SUCCESS;
	}
	
}
