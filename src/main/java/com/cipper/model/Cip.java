package com.cipper.model;

import java.util.Calendar;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table (name = "cip")
public class Cip {
	private int idCip;
	private String testo;
	private int idAutore;
	private int likes;
	private int shares;
	private Calendar data;
	
	public Cip() {
		super();
	}
	
	@Id
	@Column (name = "idCip")
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	public int getIdCip() {
		return idCip;
	}
	public void setIdCip(int idCip) {
		this.idCip = idCip;
	}
	public String getTesto() {
		return testo;
	}
	public void setTesto(String testo) {
		this.testo = testo;
	}
	public int getIdAutore() {
		return idAutore;
	}
	public void setIdAutore(int idAutore) {
		this.idAutore = idAutore;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	public int getShares() {
		return shares;
	}
	public void setShares(int shares) {
		this.shares = shares;
	}
	public Calendar getData() {
		return data;
	}
	public void setData(Calendar data) {
		this.data = data;
	}
	
	
	
}
