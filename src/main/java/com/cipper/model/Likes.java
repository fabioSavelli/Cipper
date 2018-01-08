package com.cipper.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table (name = "likes")
public class Likes {
	private int idLike;
	private int idUtente;
	private int idCip;
	private String valido;
	
	
	public Likes() {
		super();
	}
	
	@Id
	@Column (name = "idLike")
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	public int getIdLike() {
		return idLike;
	}
	public void setIdLike(int idLike) {
		this.idLike = idLike;
	}
	public String getValido() {
		return valido;
	}
	public void setValido(String valido) {
		this.valido = valido;
	}
	public int getIdUtente() {
		return idUtente;
	}
	public void setIdUtente(int idUtente) {
		this.idUtente = idUtente;
	}
	public int getIdCip() {
		return idCip;
	}
	public void setIdCip(int idCip) {
		this.idCip = idCip;
	}
}
