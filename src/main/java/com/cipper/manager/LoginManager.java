package com.cipper.manager;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.boot.MetadataSources;

import com.cipper.model.Utente;

public class LoginManager {
	protected static SessionFactory sessionFactory=null;
	
	public LoginManager() { 
		final StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();
		try {
			sessionFactory = new MetadataSources(registry).buildMetadata().buildSessionFactory();
		}
		catch (Exception e) {
			// TODO: handle exception
			StandardServiceRegistryBuilder.destroy(registry);
		}
	}
	
	protected void exit() {
		sessionFactory.close();
	}
	
	public Utente read(int id) {
		Session session = sessionFactory.openSession();
		session.beginTransaction();

		Utente utente = (Utente)session.get(Utente.class, id);
		
		session.close();
		return utente;
	}
	
	public String getUsername(int id) {
		return read(id).getUsername();
	}
	
	public String getFoto(int id) {
		return read(id).getFoto();
	}
	
	public ArrayList<Utente> allUtenti(){
		ArrayList<Utente> ret = new ArrayList<Utente>();
		for(int i=0; true; i++) {
			Utente attuale = read(i+1);
			if(attuale==null) {
				break;
			}
			else {
				ret.add(attuale);
			} 
		}
		return ret;
	}
	
	public void modificaPassword(Utente u, String psw) {
		u.setPsw(psw);
		
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		
		session.update(u);
		
		session.getTransaction().commit();
		session.close();
	}
	
	public void modificaFoto(Utente u, String foto) {
		u.setFoto(foto);
		
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		
		session.update(u);
		
		session.getTransaction().commit();
		session.close();
	}
	
	public void eliminaUtente(Utente u) {
		u.setAttivo("NO");
		
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		
		session.update(u);
		
		session.getTransaction().commit();
		session.close();
	}
	
	public void riattivaUtente(Utente u) {
		u.setAttivo("SI");
		
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		
		session.update(u);
		
		session.getTransaction().commit();
		session.close();
	}
}
