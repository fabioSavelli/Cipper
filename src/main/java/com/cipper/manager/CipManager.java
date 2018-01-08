package com.cipper.manager;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

import com.cipper.model.Cip;
import com.cipper.model.Utente;

public class CipManager {
	protected static SessionFactory sessionFactory=null;
	
	public CipManager() { 
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
	
	public Cip read(int id) {
		Session session = sessionFactory.openSession();
		session.beginTransaction();

		Cip cip = (Cip)session.get(Cip.class, id);
		
		session.close();
		return cip;
	}
	
	public ArrayList<Cip> getAllMyCip(int idAutore){
		ArrayList<Cip> ret1 = new ArrayList<Cip>();
		ArrayList<Cip> ret2 = new ArrayList<Cip>();
		int i;
		for(i=0; true; i++) {
			Cip attuale = read(i+1);
			if(attuale==null) {
				break;
			}
			else if(attuale.getIdAutore()==idAutore) {
				ret1.add(attuale);
			}
		}
		for(i=0; i<ret1.size(); i++) {
			ret2.add(ret1.get(ret1.size()-i-1));
		}
		return ret2;
	}
	
	private Cip getCipMaxLike(ArrayList<Cip> a) {
		Cip ret = new Cip();
		int i, massimo=0;
		for(i=0; i<a.size(); i++) {
			if(a.get(i).getLikes() >= massimo) {
				massimo = a.get(i).getLikes();
				ret = a.get(i);
			}
		}
		return ret;
	}
	
	private ArrayList<Cip> getPiuLike(){
		ArrayList<Cip> ret = new ArrayList<Cip>();
		ArrayList<Cip> tutti = new ArrayList<Cip>();
		int i;
			
		for(i=0; true; i++) {
			Cip attuale = read(i+1);
			if(attuale==null) {
				break;
			}
			tutti.add(attuale);
		}
		 
		for(i=0; i<3; i++) {
			if(tutti.size() == 0)
				return ret;
			else {
				Cip attuale = getCipMaxLike(tutti);
				ret.add(attuale);
				tutti.remove(attuale);
			}
		}
		
		return ret;
	}
	
	private Cip getCipMaxShare(ArrayList<Cip> a) {
		Cip ret = new Cip();
		int i, massimo=0;
		for(i=0; i<a.size(); i++) {
			if(a.get(i).getShares() >= massimo) {
				massimo = a.get(i).getShares();
				ret = a.get(i);
			}
		}
		return ret;
	}
	
	private ArrayList<Cip> getPiuShare(){
		ArrayList<Cip> ret = new ArrayList<Cip>();
		ArrayList<Cip> tutti = new ArrayList<Cip>();
		int i;
			
		for(i=0; true; i++) {
			Cip attuale = read(i+1);
			if(attuale==null) {
				break;
			}
			tutti.add(attuale);
		}
		
		for(i=0; i<3; i++) {
			if(tutti.size()==0)
				return ret;
			else {
				Cip attuale = getCipMaxShare(tutti);
				ret.add(attuale);
				tutti.remove(attuale);
			}
		}
		 	
		return ret;
	}
	
	private ArrayList<Cip> getUltimiSeguiti(int idUtente){
		ArrayList<Cip> ret1 = new ArrayList<Cip>();
		ArrayList<Cip> ret2 = new ArrayList<Cip>();
		FollowerManager fm = new FollowerManager();
		ArrayList<Utente> seguiti = fm.seguo(idUtente);
		
		for(int i=0; true; i++) {
			Cip attuale = read(i+1);
			if(attuale==null)
				break;
			for(int j=0; j<seguiti.size(); j++) {
				if(attuale.getIdAutore() == seguiti.get(j).getIdUtente()) {
					ret1.add(attuale);
					break;
				}
			}
		}
		
		for(int i=0; i<ret1.size(); i++) {
			ret2.add(ret1.get(ret1.size()-i-1));
		}
		
		return ret2;
	}
	
	private ArrayList<Cip> ordineHome(ArrayList<Cip> a){

		//ordino
		Cip[] array = new Cip[a.size()];
		for(int i=0; i<a.size(); i++)
			array[i] = a.get(i);
		
		for(int i=0; i<array.length; i++) {
			for(int j=i+1; j<array.length; j++) {
				if(array[i].getIdCip() < array[j].getIdCip()) {
					Cip temp = array[i];
					array[i] = array[j];
					array[j] = temp;
				}		
			}
		}
		
		ArrayList<Cip> ret = new ArrayList<Cip>();
		for(int i=0; i<array.length-1; i++) {
			if(i==0)
				ret.add(array[i]);
			if(array[i].getIdCip() != array[i+1].getIdCip())
				ret.add(array[i+1]);
		}
		
		return ret;
	}
	
	 // nella home vedo ultimi 5 miei cip, 3 cip con più like, 3 cip con più share, ultimi 10 cip delle persone che seguo
	public ArrayList<Cip> getHomeCip(int idUtente){
		
		ArrayList<Cip> ret = new ArrayList<Cip>();
		
		ArrayList<Cip> mieiCip 		= getAllMyCip(idUtente);
		ArrayList<Cip> ultimiSeguiti	= getUltimiSeguiti(idUtente);
		ArrayList<Cip> piuLike  		= getPiuLike();
		ArrayList<Cip> piuShare 		= getPiuShare();
		
		int quantiMiei = 5, quantiFollower = 10, quantiLike = 3, quantiShare = 3, i;
		if(mieiCip.size() < 5)
			quantiMiei = mieiCip.size(); 
		
		if(ultimiSeguiti.size() < 10)
			quantiFollower = ultimiSeguiti.size();
		
		if(piuLike.size() < 3)
			quantiLike = piuLike.size();
		
		if(piuShare.size() < 3)
			quantiShare = piuShare.size();
		
		for(i=0; i<quantiMiei; i++)
			ret.add(mieiCip.get(i));

		for(i=0; i<quantiFollower; i++)
			ret.add(ultimiSeguiti.get(i));
		
		for(i=0; i<quantiLike; i++)
			ret.add(piuLike.get(i));
		
		for(i=0; i<quantiShare; i++)
			ret.add(piuShare.get(i));
		
		return ordineHome(ret);
	}
	
	public void create (Cip c) {
		Session session = sessionFactory.openSession();
		session.beginTransaction();
				
		session.save(c);
		
		session.getTransaction().commit();
		session.close();
	}
	
	public void inserisciLike (int idCip, int aggiungi) {
		Cip cip = read(idCip);
		
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		
		cip.setLikes(cip.getLikes() + aggiungi);
		session.update(cip);
		
		session.getTransaction().commit();
		session.close();
	}
	
	public void inserisciShare (Cip cip) {
		cip.setShares(cip.getShares()+1);
		
		Session session = sessionFactory.openSession();
		session.beginTransaction();
				
		session.update(cip);
		
		session.getTransaction().commit();
		session.close();
	}
	
	public boolean mioLike(int idUtente, int idCip) {
		LikesManager lkm = new LikesManager();
		return lkm.getThisLike(idUtente, idCip);
	}
	
	public String stampaData(Calendar data) {
		SimpleDateFormat format1 = new SimpleDateFormat("dd");
		SimpleDateFormat format2 = new SimpleDateFormat("MM");
		SimpleDateFormat format3 = new SimpleDateFormat("yyyy");

		int nGior = Integer.parseInt(format1.format(data.getTime()));
		int nMese = Integer.parseInt(format2.format(data.getTime()));
		int nAnno = Integer.parseInt(format3.format(data.getTime()));
		
		String mese="";
		if(nMese==1)  mese = "Gen";
		if(nMese==2)  mese = "Feb";
		if(nMese==3)  mese = "Mar";
		if(nMese==4)  mese = "Apr";
		if(nMese==5)  mese = "Mag";
		if(nMese==6)  mese = "Giu";
		if(nMese==7)  mese = "Lug";
		if(nMese==8)  mese = "Ago";
		if(nMese==9)  mese = "Set";
		if(nMese==10) mese = "Ott";
		if(nMese==11) mese = "Nov";
		if(nMese==12) mese = "Dic";
				
		return nGior+" "+mese+" "+nAnno;
	}
	
	public String stampaTesto(String testo) {
		return testo.replaceAll("\n", "<br>");
	}
}
