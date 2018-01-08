package com.cipper.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table (name = "utente")
public class Utente {
	
	private int idUtente;
	private String username;
	private String email;
	private String psw;
	private String foto;
	private String attivo;
	
	public Utente() {
		super();
	}
	
	@Id
	@Column (name = "idUtente")
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	public int getIdUtente() {
		return idUtente;
	}
	public void setIdUtente(int idUtente) {
		this.idUtente = idUtente;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPsw() {
		return psw;
	}
	public void setPsw(String psw) {
		this.psw = psw;
	}
	public String getFoto() {
		return foto;
	}
	public void setFoto(String foto) {
		this.foto = foto;
	}
	public String getAttivo() {
		return attivo;
	}
	public void setAttivo(String attivo) {
		this.attivo = attivo;
	}
	
}
