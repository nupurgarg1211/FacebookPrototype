package org.iiitb.facebook.action;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.iiitb.facebook.dao.FindFriendsDAO;
import org.iiitb.facebook.model.returnlist_findfriends;
import org.iiitb.facebook.dao.impl.FindFriendsDAOImpl;
import org.iiitb.facebook.model.User;

public class FindFriendsAction {
	private ArrayList<returnlist_findfriends> returnlist = new ArrayList<returnlist_findfriends>();
	private ArrayList<returnlist_findfriends> peopleyoumayknow;
	private ArrayList<returnlist_findfriends> peopleyoumayknowall;
	
	public ArrayList<returnlist_findfriends> getPeopleyoumayknow() {
		return peopleyoumayknow;
	}

	public void setPeopleyoumayknow(ArrayList<returnlist_findfriends> peopleyoumayknow) {
		this.peopleyoumayknow = peopleyoumayknow;
	}
	public ArrayList<returnlist_findfriends> getPeopleyoumayknowall() {
		return peopleyoumayknowall;
	}

	public void setPeopleyoumayknowall(ArrayList<returnlist_findfriends> peopleyoumayknowall) {
		this.peopleyoumayknowall = peopleyoumayknowall;
	}


	public String execute_homepage(){
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		int k=0,i=0,size=0;
		System.out.println("inFFAction");
		FindFriendsDAO ff = new FindFriendsDAOImpl();
		returnlist=ff.getAllFriends(Integer.parseInt(u.getUserId()));
		ArrayList<returnlist_findfriends> peopleyoumay = new ArrayList<returnlist_findfriends>();
		if(returnlist.size()<3)
			size=returnlist.size();
		else
			size=3;
		for(k=0;k<size;k++){	
			//System.out.println(returnlist.get(k).getFirst_name());
			returnlist_findfriends rff = new returnlist_findfriends(returnlist.get(k).getUser_id(),returnlist.get(k).getFirst_name(),returnlist.get(k).getLast_name(),returnlist.get(k).getProfile_pic(),returnlist.get(k).getNo_of_mutualfriends(),returnlist.get(k).getMutualfriends_first_name(),returnlist.get(k).getMutualfriends_last_name(),returnlist.get(k).getMutualfriends_user_id(),returnlist.get(k).getMutualfriends_profile_pic()); 
			peopleyoumay.add(rff);
			/*for(i=0;i<returnlist.get(k).getMutualfriends_first_name().size();i++)
			System.out.println(returnlist.get(k).getMutualfriends_first_name().get(i));
			*/
		}//end of for
		setPeopleyoumayknow(peopleyoumay);
		
		/*for(i=0;i<peopleyoumayknow.get(1).getMutualfriends_first_name().size();i++)
			System.out.println("data=="+peopleyoumayknow.get(0).getMutualfriends_first_name().get(i));
		*/
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("peopleyoumayknow", peopleyoumayknow);
		session.setAttribute("peopleyoumayknowsize", peopleyoumayknow.size());
		//request.setAttribute("peopleyoumayknowsize", peopleyoumayknow.size());
		return "success";
	}
		
	public String execute_findfriendspage(){
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		
		int k=0,i=0;
		//System.out.println("inFFAction");
		FindFriendsDAO ff = new FindFriendsDAOImpl();
		returnlist=ff.getAllFriends(Integer.parseInt(u.getUserId()));
		ArrayList<returnlist_findfriends> peopleyoumayall = new ArrayList<returnlist_findfriends>();
		for(k=0;k<(returnlist.size());k++){	
			//System.out.println(returnlist.get(k).getFirst_name());
			returnlist_findfriends rff = new returnlist_findfriends(returnlist.get(k).getUser_id(),returnlist.get(k).getFirst_name(),returnlist.get(k).getLast_name(),returnlist.get(k).getProfile_pic(),returnlist.get(k).getNo_of_mutualfriends(),returnlist.get(k).getMutualfriends_first_name(),returnlist.get(k).getMutualfriends_last_name(),returnlist.get(k).getMutualfriends_user_id(),returnlist.get(k).getMutualfriends_profile_pic()); 
			peopleyoumayall.add(rff);
		}
		setPeopleyoumayknowall(peopleyoumayall);
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("peopleyoumayknowall", peopleyoumayknowall);
		session.setAttribute("peopleyoumayknowallsize", peopleyoumayknowall.size());
		return "success";
	}
	/*for(i=0;i<peopleyoumayknowall.size();i++)
			System.out.println("peopleyoumayknowall.getindex(i"+i+")=="+peopleyoumayknowall.get(i).name);
		*/
		
	}
	
	
	

