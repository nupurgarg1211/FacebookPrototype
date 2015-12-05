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
import org.iiitb.facebook.dao.AboutDAO;
import org.iiitb.facebook.dao.impl.AboutDAOImpl;
import org.iiitb.facebook.dao.impl.UserImageUploadDAOImpl;
import org.iiitb.facebook.model.*;
import org.iiitb.facebook.util.StringUtils;

public class AboutAction extends ActionSupport
{
	private About about;
	private ArrayList<Education> list_education;
	private ArrayList<Work> list_work;
	private ArrayList<Relationship> list_relationship;
	private String user_id;
	private String first_name;
	private String last_name;
	private String gender;
	private String dob;
	private String mobile;
	private String current_city;
	private String hometown;
	private String address;
	private String relationship;
	private String full_name;
	private String profile_pic;
	private String cover_pic;
	private String isFriend;
	
	public String getIsFriend() {
		return isFriend;
	}
	public void setIsFriend(String isFriend) {
		this.isFriend = isFriend;
	}
	public String getFull_name() {
		return full_name;
	}
	public void setFull_name(String full_name) {
		this.full_name = full_name;
	}
	public String getProfile_pic() {
		return profile_pic;
	}
	public void setProfile_pic(String profile_pic) {
		this.profile_pic = profile_pic;
	}
	public String getCover_pic() {
		return cover_pic;
	}
	public void setCover_pic(String cover_pic) {
		this.cover_pic = cover_pic;
	}
	
	
	public ArrayList<Relationship> getList_relationship() {
		return list_relationship;
	}
	public void setList_relationship(ArrayList<Relationship> list_relationship) {
		this.list_relationship = list_relationship;
	}
	public String getRelationship() {
		return relationship;
	}
	public void setRelationship(String relationship) {
		this.relationship = relationship;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getCurrent_city() {
		return current_city;
	}
	public void setCurrent_city(String current_city) {
		this.current_city = current_city;
	}
	public String getHometown() {
		return hometown;
	}
	public void setHometown(String hometown) {
		this.hometown = hometown;
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
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getDob() {
		return dob;
	}
	public void setDob(String dob) {
		this.dob = dob;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public About getAbout() {
		return about;
	}
	public void setAbout(About about) {
		this.about = about;
	}
	public ArrayList<Education> getList_education() {
		return list_education;
	}
	public void setList_education(ArrayList<Education> list_education) {
		this.list_education = list_education;
	}
	public ArrayList<Work> getList_work() {
		return list_work;
	}
	public void setList_work(ArrayList<Work> list_work) {
		this.list_work = list_work;
	}
	public void getRelationships()
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		AboutDAO adao = new AboutDAOImpl();
		list_relationship = adao.getRelations();
		request.setAttribute("list_relationship", list_relationship);
		setList_relationship(list_relationship);
	}
	public String about()
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		AboutDAO adao = new AboutDAOImpl();
		about = adao.about_details(user_id);
		list_education = adao.education_details(user_id);
		list_work = adao.work_details(user_id);
		list_relationship = adao.getRelations();
		request.setAttribute("about", about);
		request.setAttribute("list_education", list_education);
		request.setAttribute("list_work", list_work);
		request.setAttribute("list_relationship", list_relationship);
		setAbout(about);
		setList_education(list_education);
		setList_work(list_work);
		setList_relationship(list_relationship);
		
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User user=(User)session.getAttribute("user");
		
		TimelineHeaderAction tha = new TimelineHeaderAction();
		setFull_name(tha.getFullName(user_id));
		setIsFriend(tha.checkFriend(user.getUserId(), user_id));
		setProfile_pic(tha.getProfilePic(user_id));
		setCover_pic(tha.getCoverPic(user_id));
		
		
	    return "success";
	}
	
	public String aboutEditSave() throws Exception
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		getRelationships();
		AboutDAO adao = new AboutDAOImpl();
		System.out.println("here "+dob);
		adao.update_about_details(u.getUserId(), first_name, last_name, gender, dob, mobile,current_city,hometown,address,relationship);
		about = adao.about_details(u.getUserId());
		setFirst_name(about.getFirst_name());
		setLast_name(about.getLast_name());
		setGender(about.getGender());
		setDob(about.getDob());
		setMobile(about.getMobile());
		setAddress(about.getAddress());
		setHometown(about.getHometown());
		setCurrent_city(about.getCurrent_city());
		setRelationship(about.getRelationship());
		return SUCCESS;
	}
	
	public String aboutEditCancel() throws Exception
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		getRelationships();
		AboutDAO adao = new AboutDAOImpl();
		about = adao.about_details(u.getUserId());
		setFirst_name(about.getFirst_name());
		setLast_name(about.getLast_name());
		setGender(about.getGender());
		setDob(about.getDob());
		setMobile(about.getMobile());
		setAddress(about.getAddress());
		setHometown(about.getHometown());
		setCurrent_city(about.getCurrent_city());
		setRelationship(about.getRelationship());
		return SUCCESS;
	}
}
