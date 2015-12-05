package org.iiitb.facebook.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.iiitb.facebook.dao.SearchDAO;
import org.iiitb.facebook.dao.impl.SearchDAOImpl;
import org.iiitb.facebook.model.Event;
import org.iiitb.facebook.model.User;
import org.iiitb.facebook.model.UserSearch;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.util.ValueStack;

/**
 * @author nitin
 * @fileName SearchAction.java
 * @created on 08-Apr-2015
 */
public class SearchAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private String searchTerm;
	private List<UserSearch> userList;
	private Map<String,List> searchMap;
	
	HttpSession session=ServletActionContext.getRequest().getSession(false);
	User u=(User)session.getAttribute("user");
	
	public String search() {
		System.out.println("searchTerm: "+searchTerm);
		SearchDAO sd = new SearchDAOImpl();
		List<UserSearch> list = sd.search(searchTerm);
		setUserList(list);
		return SUCCESS;
	}
	
	public String searchAll(){
		System.out.println("searchTerm: "+searchTerm);
		SearchDAO sd = new SearchDAOImpl();
		Map<String,List> searchMap = sd.searchAll(searchTerm);
		setSearchMap(searchMap);
		return SUCCESS;
	}
	
	public String getSearchTerm() {
		return searchTerm;
	}

	public void setSearchTerm(String searchTerm) {
		this.searchTerm = searchTerm;
	}

	public List<UserSearch> getUserList() {
		return userList;
	}

	public void setUserList(List<UserSearch> list) {
		this.userList = list;
	}

	public Map<String, List> getSearchMap() {
		return searchMap;
	}

	public void setSearchMap(Map<String, List> searchMap) {
		this.searchMap = searchMap;
	}
}
