package com.cipper.manager;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

import com.cipper.model.Likes;

public class LikesManager {
	protected static SessionFactory sessionFactory=null;
	
	public LikesManager() { 
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
	
	private Likes read(int id) {
		Session session = sessionFactory.openSession();
		session.beginTransaction();

		Likes like= (Likes)session.get(Likes.class, id);
		
		session.close();
		return like;
	}
	
	public ArrayList<Likes> getAllLikes(){
		ArrayList<Likes> ret = new ArrayList<Likes>();
		
		for(int i=0; true; i++) {
			Likes attuale = read(i+1);
			if(attuale == null)
				return ret;
			else
				ret.add(attuale);
		}
	}
	
	public boolean getThisLike(int idUtente, int idCip) {
		ArrayList<Likes> tutti = getAllLikes();
		for(int i=0; i<tutti.size(); i++) {
			Likes attuale = tutti.get(i);
			if(attuale.getIdCip()==idCip && attuale.getIdUtente()==idUtente && attuale.getValido().equals("OK"))
				return true;
			else if(attuale.getIdCip()==idCip && attuale.getIdUtente()==idUtente && attuale.getValido().equals("NO"))
				return false;
		}
		return false;
	}
	
	public boolean create (Likes l) {
		ArrayList<Likes> tutti = getAllLikes();
		
		for(int i=0; i<tutti.size(); i++) {
			Likes attuale = tutti.get(i);
			
			if(attuale.getIdUtente()==l.getIdUtente() && attuale.getIdCip()==l.getIdCip() && attuale.getValido().equals("NO")){
				attuale.setValido("OK");
				
				Session session = sessionFactory.openSession();
				session.beginTransaction();
				
				session.update(attuale);
				
				session.getTransaction().commit();
				session.close();
				
				// incrementare numero like del cip
				CipManager cm = new CipManager();
				cm.inserisciLike(attuale.getIdCip(), 1);
				
				return true;
			} 
			else if(attuale.getIdUtente()==l.getIdUtente() && attuale.getIdCip()==l.getIdCip() && attuale.getValido().equals("OK")){
				attuale.setValido("NO");
				
				Session session = sessionFactory.openSession();
				session.beginTransaction();
								
				session.update(attuale);
				
				session.getTransaction().commit();
				session.close();
				
				// decrementare numero like del cip
				CipManager cm = new CipManager();
				cm.inserisciLike(attuale.getIdCip(), -1);
				
				return false;
			}
		}
		
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		
		l.setValido("OK");
		session.save(l);
			
		session.getTransaction().commit();
		session.close();
		
		// incrementare numero like del cip
		CipManager cm = new CipManager();
		cm.inserisciLike(l.getIdCip(), 1);
		
		return true;
	}

}
