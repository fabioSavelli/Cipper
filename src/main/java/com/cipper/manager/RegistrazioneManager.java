package com.cipper.manager;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

import com.cipper.model.Utente;

public class RegistrazioneManager {
	protected static SessionFactory sessionFactory=null;
	
	public RegistrazioneManager() { 
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
	
	public void create (Utente u) {
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		
		session.save(u);
		
		session.getTransaction().commit();
		session.close();
	}
	
	public int prossimoId() {
		int ret = 0;
		LoginManager lm = new LoginManager();
		for(int i=0; true; i++) {
			if(lm.read(i+1)==null) {
				ret = i+1;
				break;
			}
		}
		return ret;
	}
}
