package com.cipper.action;

import java.io.File;

import org.apache.commons.io.FileUtils;

import com.cipper.manager.LoginManager;
import com.cipper.model.Utente;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ModificaProfiloAction extends ActionSupport {
	Utente utente;
	File userImage;
	String password, confPassword, errori, errori2, userImageContentType, userImageFileName;

	public Utente getUtente() {
		return utente;
	}
	public void setUtente(Utente utente) {
		this.utente = utente;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getConfPassword() {
		return confPassword;
	}
	public void setConfPassword(String confPassword) {
		this.confPassword = confPassword;
	}
	public String getErrori() {
		return errori;
	}
	public void setErrori(String errori) {
		this.errori = errori;
	}
	public String getErrori2() {
		return errori2;
	}
	public void setErrori2(String errori2) {
		this.errori2 = errori2;
	}
	public File getUserImage() {
		return userImage;
	}
	public void setUserImage(File userImage) {
		this.userImage = userImage;
	}
	public String getUserImageContentType() {
		return userImageContentType;
	}
	public void setUserImageContentType(String userImageContentType) {
		this.userImageContentType = userImageContentType;
	}
	public String getUserImageFileName() {
		return userImageFileName;
	}
	public void setUserImageFileName(String userImageFileName) {
		this.userImageFileName = userImageFileName;
	}
	
	public String execute() {
		LoginManager lm = new LoginManager();
		utente = lm.read(utente.getIdUtente());
		return SUCCESS;
	}
	
	public String modificaFoto() {
		LoginManager lm = new LoginManager();
		utente  = lm.read(utente.getIdUtente());
		errori2 = "";
		
		try {
			String filePath = "/Users/Fabio/Desktop/Lavoro/progetti/cipperProva/src/main/webapp/fotoUtente/";					
			this.userImageFileName = ""+utente.getIdUtente()+"-"+this.userImageFileName;
			File fileToCreate = new File(filePath, this.userImageFileName);
			FileUtils.copyFile(this.userImage, fileToCreate);
			
			lm.modificaFoto(utente,"fotoUtente/"+this.userImageFileName);		
		} 
		catch (Exception e) {
			errori2 += " 1";
			System.out.println("ciao");
			return "input";
		}
		
		addActionMessage("La foto è stata modificata correttamente");
		return SUCCESS;
	}
	
	public String modificaPassword() {
		LoginManager lm = new LoginManager();
		utente = lm.read(utente.getIdUtente());
		errori = "";
		if(password.equals("")) {
			errori += " 1";
			return "input";
		}
		if(!confPassword.equals(password)) {
			errori += " 2";
			return "input";
		}
		lm.modificaPassword(utente, password);
		
		addActionMessage("La password è stata modificata correttamente");
		return SUCCESS;
	}
	
}
