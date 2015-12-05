package org.iiitb.facebook.action;


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
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.iiitb.facebook.dao.AboutDAO;
import org.iiitb.facebook.dao.impl.AboutDAOImpl;
import org.iiitb.facebook.model.*;
import org.iiitb.facebook.util.StringUtils;

public class WorkEducationAction extends ActionSupport
{
	public String we_id;
	public String organization;
	public String position;
	public String start_date;
	public String end_date;
	public WorkEducation we;
	private About about;
	private ArrayList<Education> list_education;
	private ArrayList<Work> list_work;
	private ArrayList<Relationship> list_relationship;
	
	public ArrayList<Relationship> getList_relationship() {
		return list_relationship;
	}

	public void setList_relationship(ArrayList<Relationship> list_relationship) {
		this.list_relationship = list_relationship;
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

	public String getWe_id() {
		return we_id;
	}

	public void setWe_id(String we_id) {
		this.we_id = we_id;
	}

	public String getOrganization() {
		return organization;
	}

	public void setOrganization(String organization) {
		this.organization = organization;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public WorkEducation getWe() {
		return we;
	}

	public void setWe(WorkEducation we) {
		this.we = we;
	}

	public String educationEditSave() throws Exception
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		AboutDAO adao = new AboutDAOImpl();
		adao.update_we_details(we_id, organization, position, start_date, end_date);
		we = adao.get_we_details(we_id);
		setOrganization(we.getOrganization());
		setPosition(we.getPosition());
		setStart_date(we.getStart_date());
		setEnd_date(we.getEnd_date());
		return SUCCESS;
	}
	public String educationEditCancel() throws Exception
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		AboutDAO adao = new AboutDAOImpl();
		we = adao.get_we_details(we_id);
		setOrganization(we.getOrganization());
		setPosition(we.getPosition());
		setStart_date(we.getStart_date());
		setEnd_date(we.getEnd_date());
		return SUCCESS;
	}
	public String addEducation() throws Exception
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		String type = "education";
		String userId = u.getUserId();
		AboutDAO adao = new AboutDAOImpl();
		boolean flag = adao.addWorkEducation(userId,type,organization,position,start_date,end_date);
		about = adao.about_details(u.getUserId());
		list_education = adao.education_details(u.getUserId());
		list_work = adao.work_details(u.getUserId());
		list_relationship = adao.getRelations();
		request.setAttribute("about", about);
		request.setAttribute("list_education", list_education);
		request.setAttribute("list_work", list_work);
		request.setAttribute("list_relationship", list_relationship);
		
		setAbout(about);
		setList_education(list_education);
		setList_work(list_work);
		setList_relationship(list_relationship);
		HttpServletResponse response=ServletActionContext.getResponse();
		response.sendRedirect(StringUtils.hostname+"/FacebookDemo/about?user_id="+u.getUserId());
		if(flag)
			return SUCCESS;
		else
			return ERROR;
	}
	public String addWork() throws Exception
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		String type = "work";
		String userId = u.getUserId();
		AboutDAO adao = new AboutDAOImpl();
		boolean flag = adao.addWorkEducation(userId,type,organization,position,start_date,end_date);
		about = adao.about_details(u.getUserId());
		list_education = adao.education_details(u.getUserId());
		list_work = adao.work_details(u.getUserId());
		list_relationship = adao.getRelations();
		request.setAttribute("about", about);
		request.setAttribute("list_education", list_education);
		request.setAttribute("list_work", list_work);
		request.setAttribute("list_relationship", list_relationship);
		setAbout(about);
		setList_education(list_education);
		setList_work(list_work);
		setList_relationship(list_relationship);
		HttpServletResponse response=ServletActionContext.getResponse();
		response.sendRedirect(StringUtils.hostname+"/FacebookDemo/about?user_id="+u.getUserId());
		if(flag)
			return SUCCESS;
		else
			return ERROR;
	}
	public String deleteWorkEducation() throws Exception
	{
		AboutDAO adao = new AboutDAOImpl();
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		boolean flag = adao.deleteWorkEducation(we_id);
		HttpServletResponse response=ServletActionContext.getResponse();
		response.sendRedirect(StringUtils.hostname+"/FacebookDemo/about?user_id="+u.getUserId());
		if(flag)
			return SUCCESS;
		else
			return ERROR;
	}
}
