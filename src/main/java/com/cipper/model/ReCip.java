package com.cipper.model;

import java.util.Calendar;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table (name = "reCip")
public class ReCip {
	private int idReCip;
	private int idUtente;
	private int idCip;
	private Calendar dataReCip;
	
	
	public ReCip() {
		super();
	}
	
	@Id
	@Column (name = "idReCip")
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	public int getIdReCip() {
		return idReCip;
	}
	public void setIdReCip(int idReCip) {
		this.idReCip = idReCip;
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
	public Calendar getDataReCip() {
		return dataReCip;
	}
	public void setDataReCip(Calendar dataReCip) {
		this.dataReCip = dataReCip;
	}
}
