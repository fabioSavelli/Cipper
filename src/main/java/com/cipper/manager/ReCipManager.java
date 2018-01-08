package com.cipper.manager;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

import com.cipper.model.ReCip;
import com.cipper.model.Utente;

public class ReCipManager {
	protected static SessionFactory sessionFactory=null;
	
	public ReCipManager() { 
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
	
	public ReCip read(int id) {
		Session session = sessionFactory.openSession();
		session.beginTransaction();

		ReCip reCip = (ReCip)session.get(ReCip.class, id);
		
		session.close();
		return reCip;
	} 
	
	public void create (ReCip rc) {
		Session session = sessionFactory.openSession();
		session.beginTransaction();
				
		session.save(rc);
		
		session.getTransaction().commit();
		session.close();
	}
	
	private ArrayList<ReCip> ordina(ArrayList<ReCip> a){
		ArrayList<ReCip> ret = new ArrayList<ReCip>();
		for(int i=0; i<a.size(); i++) {
			ret.add(a.get(a.size()-1-i));
		}
		return ret;
	}
	
	public ArrayList<ReCip> getAllMyReCip(Utente utente){
		ArrayList<ReCip> ret = new ArrayList<ReCip>();
		
		for(int i=0; true; i++) {
			ReCip attuale = read(i+1);
			if(attuale==null)
				return ordina(ret);
			else if(attuale.getIdUtente()==utente.getIdUtente())
				ret.add(attuale);
		}
	}
}
