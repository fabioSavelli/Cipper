package com.cipper.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table (name = "follower")
public class Follower {
	private int idFollower;
	private int idUtente;
	private int idSeguito;
	private String valido;
	
	public Follower() {
		super();
	}
	
	@Id
	@Column (name = "idFollower")
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	public int getIdFollower() {
		return idFollower;
	}
	public void setIdFollower(int idFollower) {
		this.idFollower = idFollower;
	}
	public int getIdUtente() {
		return idUtente;
	}
	public void setIdUtente(int idUtente) {
		this.idUtente = idUtente;
	}
	public int getIdSeguito() {
		return idSeguito;
	}
	public void setIdSeguito(int idSeguito) {
		this.idSeguito = idSeguito;
	}
	public String getValido() {
		return valido;
	}
	public void setValido(String valido) {
		this.valido = valido;
	}
	
}
