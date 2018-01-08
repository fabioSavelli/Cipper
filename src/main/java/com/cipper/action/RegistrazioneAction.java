package com.cipper.action;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.interceptor.ServletRequestAware;

import com.cipper.manager.LoginManager;
import com.cipper.manager.RegistrazioneManager;
import com.cipper.model.Utente;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class RegistrazioneAction extends ActionSupport implements ServletRequestAware{
	Utente utente, nuovoUtente;
	String confPassword, errori;
	
	private File userImage;
	private String userImageContentType;
	private String userImageFileName;

	private HttpServletRequest servletRequest;
	
	
	public String getErrori() {
		return errori;
	}
	public void setErrori(String errori) {
		this.errori = errori;
	}
	public Utente getNuovoUtente() {
		return nuovoUtente;
	}
	public void setNuovoUtente(Utente nuovoUtente) {
		this.nuovoUtente = nuovoUtente;
	}
	public Utente getUtente() {
		return utente;
	}
	public void setUtente(Utente utente) {
		this.utente = utente;
	}
	public String getConfPassword() {
		return confPassword;
	}
	public void setConfPassword(String confPassword) {
		this.confPassword = confPassword;
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

	public void setServletRequest(HttpServletRequest servletRequest) {
		this.servletRequest = servletRequest;

	}
	
	public void validate() {
		boolean valido = true;
		errori = "";
		
		Utente newUtente = new Utente();
		newUtente.setUsername(nuovoUtente.getUsername());
		newUtente.setEmail(nuovoUtente.getEmail());
		newUtente.setPsw(nuovoUtente.getPsw());
		newUtente.setFoto(nuovoUtente.getFoto());
		
		if(newUtente.getUsername().equals("")) {
			addActionError("1"); //inserisci username
			errori += " 1";
			valido = false;
		}
		if(newUtente.getEmail().equals("")) {
			addActionError("2"); //inserisci email
			errori += " 2";
			valido = false;
		}
		if(newUtente.getPsw().equals("")) {
			addActionError("3"); //inserisci la password
			errori += " 3";
			valido = false;
		}
		if(! newUtente.getPsw().equals(confPassword)) {
			addActionError("4"); //le password non coincidono
			errori += " 4";
			valido = false;
		}
		
		if(valido) {
			LoginManager lm = new LoginManager();
			ArrayList<Utente> tutti = lm.allUtenti();
			
			boolean giaInserito = false;
			for(int i=0; i<tutti.size(); i++) {
				
				if (tutti.get(i).getEmail().equals(newUtente.getEmail()) && 
					tutti.get(i).getUsername().equals(newUtente.getUsername()) &&
					tutti.get(i).getAttivo().equals("NO")) {
					
					tutti.get(i).setPsw(confPassword);
					lm.riattivaUtente(tutti.get(i));
					utente = tutti.get(i);
					return;
				}
					
				if (tutti.get(i).getEmail().equals(newUtente.getEmail())){
					giaInserito = true;
					addActionError("5"); //email già presente
					errori += " 5";
				}
				if (tutti.get(i).getUsername().equals(newUtente.getUsername())) {
					giaInserito = true;
					addActionError("6"); //username già presente
					errori += " 6";
				}
			}
			
			if(!giaInserito) {
				RegistrazioneManager rm = new RegistrazioneManager();
				
				try {
					String filePath = "/Users/Fabio/Desktop/Lavoro/progetti/cipperProva/src/main/webapp/fotoUtente/";					
					this.userImageFileName = ""+rm.prossimoId()+"-"+this.userImageFileName;
					File fileToCreate = new File(filePath, this.userImageFileName);
					FileUtils.copyFile(this.userImage, fileToCreate);
					
					nuovoUtente.setFoto("fotoUtente/"+this.userImageFileName);		
				} 
				catch (Exception e) {
					nuovoUtente.setFoto("images/placeholder.jpg");
					e.printStackTrace();
				}
				
				nuovoUtente.setAttivo("SI");
				rm.create(nuovoUtente);
				addActionMessage("Ti sei registrato correttamente");
				utente = nuovoUtente;
			}
		}
	}
	
	public String execute() {
		return SUCCESS;
	}
	
	
}
