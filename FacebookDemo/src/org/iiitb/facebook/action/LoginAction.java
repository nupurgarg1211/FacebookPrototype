package org.iiitb.facebook.action;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import javax.naming.NamingException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.SessionMap;
import org.apache.struts2.interceptor.SessionAware;
import org.iiitb.facebook.dao.LoginDAO;
import org.iiitb.facebook.dao.impl.LoginDAOimpl;
import org.iiitb.facebook.model.User;
import org.iiitb.facebook.util.StringUtils;

import com.opensymphony.xwork2.ActionSupport;

public class LoginAction extends ActionSupport implements SessionAware{
	private String userID;
	private String password;
	private SessionMap<String, Object> session;

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Map<String, Object> getSession()
	{
		return session;
	}
	
	@Override
	public void setSession(Map<String, Object> session) {
		this.session=(SessionMap)session;
	}
	
	public String execute() throws NamingException, SQLException, IOException
	{
		System.out.println(":::::::::::::::::"+session);
		User user = (User) session.get("user");
		System.out.println(userID+" "+password);
		if (user != null)
		{
			return "home";
		}
		else{
			LoginDAO ld=new LoginDAOimpl();
			user=ld.isValidUser(userID,password);
			if(user.getErrorFlag()==0){
				session.put("user", user);
				session.put("login", true);
				User test=(User)session.get("user");
				System.out.println(test.getFirstName());
				System.out.println(test.getLastName());
				HttpServletResponse response=ServletActionContext.getResponse();
				response.sendRedirect(StringUtils.hostname+"/FacebookDemo/newsFeedAction");
				return "home";
			}else{
				addActionError(user.getErrorMessage());
//				if(user.getErrorFlag()==2){
//					return "login";
//				}else if(user.getErrorFlag()==1){
//					return "login";
//				}else if(user.getErrorFlag()==3){
//					return "login";
//				}else if(user.getErrorFlag()==4){
//					return "login";
//				}		
				return "login";
			}
		}
	}
	
	public String logout(){  
	    if(session!=null && session.get("login")!=null){
	    	DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    	Date dateobj = new Date();
	    	LoginDAO ld=new LoginDAOimpl();
	    	User u=(User)session.get("user");
	    	ld.updateLogoutTime(u.getUserId(), df.format(dateobj).toString());
	    	session.put("login", null);
	    	session.remove("user");
	        session.invalidate();  
	    }  
	    addActionMessage("Your Account has been successfully logged out");
	    return "success";  
	}  
}
