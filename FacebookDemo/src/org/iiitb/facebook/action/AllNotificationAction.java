package org.iiitb.facebook.action;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.iiitb.facebook.dao.HeaderDAO;
import org.iiitb.facebook.dao.impl.HeaderDAOImpl;
import org.iiitb.facebook.model.Notification;
import org.iiitb.facebook.model.User;

public class AllNotificationAction {
	
		ArrayList<Notification> al;
		String user_id;
		String name;
		
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public ArrayList<Notification> getAl() {
			return al;
		}
		public void setAl(ArrayList<Notification> al) {
			this.al = al;
		}
		public String getUser_id() {
			return user_id;
		}
		public void setUser_id(String user_id) {
			this.user_id = user_id;
		}
	
		public String fetchallNotifications(){
							
			HttpSession session=ServletActionContext.getRequest().getSession(false);
			User u=(User)session.getAttribute("user");
			
			HeaderDAO hd = new HeaderDAOImpl();  
			setAl(hd.getallNotifications(Integer.parseInt(u.getUserId())));
			return "success";
			
		}
		
		public String clearNotifications(){
			HttpSession session=ServletActionContext.getRequest().getSession(false);
			User u=(User)session.getAttribute("user");
			HeaderDAO headernoti = new HeaderDAOImpl(); 
			headernoti.clearNotifications(Integer.parseInt(u.getUserId())); 
			return "success";
		}
		
		public String addNotification(String notification_type,String user_from,String user_to,String message,String url,String date){
			
			HeaderDAO headernoti = new HeaderDAOImpl(); 
			headernoti.insertNewNotification(notification_type,user_from,user_to,message,url,date,"F"); 
			return "success";
		}
		
}
