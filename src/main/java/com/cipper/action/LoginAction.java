package com.cipper.action;


import java.util.ArrayList;

import com.cipper.manager.LoginManager;
import com.cipper.model.Utente;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.dispatcher.SessionMap;  

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;  
import org.apache.struts2.ServletActionContext; 

@SuppressWarnings("serial")
public class LoginAction extends ActionSupport{
	Utente utente;
	SessionMap<String,String> sessionmap;  

	public Utente getUtente() {
		return utente;
	}

	public void setUtente(Utente utente) {
		this.utente = utente;
	}

	public void validate(){
		boolean valido = true;
		
		if(utente==null) 
			return;
		
		if(utente.getEmail().equals("")) {
			addActionMessage("inserisci la tua email");
			addFieldError("", "");
			valido=false;
			return;
		}
		if(utente.getPsw().equals("")) {
			addActionMessage("inserisci la tua password");			
			addFieldError("", "");
			valido=false;
			return;
		}
		
		if(valido) {
			LoginManager lm = new LoginManager();
			ArrayList<Utente> tutti = lm.allUtenti();
			
			boolean corretto = false;
			for(int i=0; i<tutti.size(); i++) {
				if (tutti.get(i).getEmail().equals(utente.getEmail()) && 
				    tutti.get(i).getPsw().equals(utente.getPsw()) &&
				    tutti.get(i).getAttivo().equals("SI")){
					
					corretto = true;
					utente = tutti.get(i);
					break;
				}
				
				if (tutti.get(i).getEmail().equals(utente.getEmail()) && 
				    tutti.get(i).getPsw().equals(utente.getPsw()) &&
				    tutti.get(i).getAttivo().equals("NO")){
						
					addActionMessage("l'account è stato eliminato");
					addFieldError("", "");
					return;
				}
			}		
			if(!corretto) {
				addActionMessage("email o password errate");
				addFieldError("", "");
				valido=false;
				return;
			}
		}
	}
	
	public String execute() {
		
				
		HttpServletRequest request=ServletActionContext.getRequest();  
		HttpSession session=request.getSession();  
		
		session.setAttribute("login", true);
		
		return SUCCESS;
	}
	
	public String logout(){  
		HttpServletRequest request=ServletActionContext.getRequest();  
		HttpSession session=request.getSession();  
		
		if(session!=null){
            session.invalidate();
            session = null;
		}
		
	    return "success";  
	}  
}
