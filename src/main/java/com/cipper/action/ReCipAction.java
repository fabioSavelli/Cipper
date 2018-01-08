package com.cipper.action;

import java.util.Calendar;

import com.cipper.manager.CipManager;
import com.cipper.manager.LoginManager;
import com.cipper.manager.ReCipManager;
import com.cipper.model.Cip;
import com.cipper.model.ReCip;
import com.cipper.model.Utente;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ReCipAction extends ActionSupport{
	Utente utente, altro;
	Cip cip;
	
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
	public Cip getCip() {
		return cip;
	}
	public void setCip(Cip cip) {
		this.cip = cip;
	}
	
	
	public String execute() {
		LoginManager lm 		= new LoginManager();
		utente = lm.read(utente.getIdUtente());

		CipManager cm 		= new CipManager();
		cip = cm.read(cip.getIdCip());
		
		Calendar data = Calendar.getInstance();;
		
		ReCip rc = new ReCip();
		rc.setIdCip(cip.getIdCip());
		rc.setIdUtente(utente.getIdUtente());
		rc.setDataReCip(data);

		ReCipManager rcm		= new ReCipManager();
		rcm.create(rc);
		
		cm.inserisciShare(cip);
		
		return SUCCESS;
	}
	
	public String execute2() {
		LoginManager lm 		= new LoginManager();
		utente = lm.read(utente.getIdUtente());
		altro = lm.read(altro.getIdUtente());
		
		CipManager cm 		= new CipManager();
		cip = cm.read(cip.getIdCip());
		
		Calendar data = Calendar.getInstance();;
		
		ReCip rc = new ReCip();
		rc.setIdCip(cip.getIdCip());
		rc.setIdUtente(utente.getIdUtente());
		rc.setDataReCip(data);

		ReCipManager rcm		= new ReCipManager();
		rcm.create(rc);
		
		cm.inserisciShare(cip);
		
		return SUCCESS;
	}
}
