package com.cipper.manager;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

import com.cipper.model.Follower;
import com.cipper.model.Utente;

public class FollowerManager {
	protected static SessionFactory sessionFactory=null;
	
	public FollowerManager() { 
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
	
	private Follower read(int id) {
		Session session = sessionFactory.openSession();
		session.beginTransaction();

		Follower follower = (Follower)session.get(Follower.class, id);
		
		session.close();
		return follower;
	}
	
	public boolean presente(int idUtente, int idAltro) {
		for(int i=0; true; i++) {
			Follower attuale = read(i+1);
			if(attuale==null) {
				return false;
			}
			else if(attuale.getIdUtente()==idUtente && attuale.getIdSeguito()==idAltro && attuale.getValido().equals("OK")){
				return true;
			} 
		}
	}
	
	private int getId(int idUtente, int idAltro) {
		for(int i=0; true; i++) {
			Follower attuale = read(i+1);
			if(attuale==null) {
				return 0;
			}
			else if(attuale.getIdUtente()==idUtente && attuale.getIdSeguito()==idAltro){
				return i+1;
			} 
		}
	}
	
	public void create (Follower f) {
		
		for(int i=0; true; i++) {
			Follower attuale = read(i+1);
			if(attuale==null) {
				Session session = sessionFactory.openSession();
				session.beginTransaction();
				
				f.setValido("OK");
				session.save(f);
					
				session.getTransaction().commit();
				session.close();
				
				return;
			}
			else if(attuale.getIdUtente()==f.getIdUtente() && attuale.getIdSeguito()==f.getIdSeguito() && attuale.getValido().equals("NO")){
				attuale.setValido("OK");
				
				Session session = sessionFactory.openSession();
				session.beginTransaction();
				
				session.update(attuale);
				
				session.getTransaction().commit();
				session.close();
				
				return;
			} 
			else if(attuale.getIdUtente()==f.getIdUtente() && attuale.getIdSeguito()==f.getIdSeguito() && attuale.getValido().equals("OK")){
				return;
			}
		}
	}
	
	public void delete(Follower f) {
		f.setIdFollower(getId(f.getIdUtente(), f.getIdSeguito()));
		f.setValido("NO");
		
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		
		session.update(f);
		
		session.getTransaction().commit();
		session.close();
	}
	
	public ArrayList<Utente> miSeguono(int idUtente){
		ArrayList<Utente> ret = new ArrayList<Utente>();
		LoginManager lm = new LoginManager();
		
		for(int i=0; true; i++) {
			Follower attuale = read(i+1);
			if(attuale == null)
				break;
			else if(attuale.getIdSeguito() == idUtente && attuale.getValido().equals("OK"))
				ret.add(lm.read(attuale.getIdUtente()));
		}
		
		return ret;
	}
	
	public ArrayList<Utente> seguo(int idUtente){
		ArrayList<Utente> ret = new ArrayList<Utente>();
		LoginManager lm = new LoginManager();
		
		for(int i=0; true; i++) {
			Follower attuale = read(i+1);
			if(attuale == null)
				break;
			else if(attuale.getIdUtente() == idUtente && attuale.getValido().equals("OK"))
				ret.add(lm.read(attuale.getIdSeguito()));
		}
		
		return ret;
	}
}
