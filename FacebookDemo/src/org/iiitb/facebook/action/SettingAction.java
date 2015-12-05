package org.iiitb.facebook.action;


import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.iiitb.facebook.dao.*;
import org.iiitb.facebook.dao.impl.*;
import org.iiitb.facebook.model.*;

public class SettingAction extends ActionSupport
{
	private About about;
	private String first_name;
	private String last_name;
	private String dob;
	private String password;
	private String message;
	private ArrayList<Group> grpList;
	
	public ArrayList<Group> getGrpList() {
		return grpList;
	}
	public void setGrpList(ArrayList<Group> grpList) {
		this.grpList = grpList;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getFirst_name() {
		return first_name;
	}
	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}
	public String getLast_name() {
		return last_name;
	}
	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}
	public String getDob() {
		return dob;
	}
	public void setDob(String dob) {
		this.dob = dob;
	}
	public About getAbout() {
		return about;
	}
	public void setAbout(About about) {
		this.about = about;
	}
	public String setting()
	{
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		HttpServletRequest request = ServletActionContext.getRequest();
		SettingDAO sdao = new SettingDAOImpl();
		about = sdao.getSetting(u.getUserId());
		GroupDAO grp = new GroupDAOImpl();
		setGrpList(grp.getAllGroups(Integer.parseInt(u.getUserId())));
		request.setAttribute("about", about);
		setAbout(about);
	    return "success";
	}
	public String saveSetting() throws Exception
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		SettingDAO sdao = new SettingDAOImpl();
		boolean flag = sdao.saveSetting(u.getUserId(), first_name, last_name, dob, password);
		if(flag)
			setMessage("Your setting have been saved.");
		else
			setMessage("Some problem occured. Please try after sometime.");
		about = sdao.getSetting(u.getUserId());
		setFirst_name(about.getFirst_name());
		setLast_name(about.getLast_name());
		setDob(about.getDob());
		setPassword(about.getPassword());
		GroupDAO grp = new GroupDAOImpl();
		setGrpList(grp.getAllGroups(Integer.parseInt(u.getUserId())));
		return SUCCESS;
	}
	public String cancelSetting()
	{
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		HttpServletRequest request = ServletActionContext.getRequest();
		SettingDAO sdao = new SettingDAOImpl();
		about = sdao.getSetting(u.getUserId());
		request.setAttribute("about", about);
		setAbout(about);
		setMessage("Your setting has not been updated.");
	    return "success";
	}
}
