package org.iiitb.facebook.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import org.apache.struts2.ServletActionContext;
import org.iiitb.facebook.dao.RegistrationDAO;
import org.iiitb.facebook.dao.impl.NewsFeedDAOImpl;
import org.iiitb.facebook.dao.impl.RegistrationDAOImpl;
import org.iiitb.facebook.util.PhotoUtil;
import org.iiitb.facebook.util.ValidateEmail;

import com.opensymphony.xwork2.ActionSupport;

public class RegistrationAction extends ActionSupport{
	
	public String firstName;
	public String lastName;
	public String email;
	public String password;
	public String birthday;
	public String gender;
	
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	
	public String execute(){
		SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String d=sf.format(new Date());
		
		System.out.println("today formatted date==>"+d);
		
		RegistrationDAO rd=new RegistrationDAOImpl();
		boolean res=rd.createuser(email, firstName, lastName, birthday, gender,password,d);
		if(res){
//			ValidateEmail ve=new ValidateEmail();
//			String message="Hi "+firstName+" "+lastName+",\n\n"+"Thank You for signing up for facebook prototype.\nPlease click on below link below to activate your account.\n";
//			message=message+"http://localhost:8080/FacebookDemo/mailVerificationAction?email="+email+"\n\n\n";
//			ve.sendMail(email,message,"Verfication Link for facebook Prototype");
//			
			RegistrationDAOImpl ed=new RegistrationDAOImpl();
			String userId=ed.getUser(email);
			PhotoUtil.firstTimeAlbumCreation(userId);
			System.out.println("userId==>"+userId);
			String destpath= ServletActionContext.getServletContext().getRealPath("path.txt");
			System.out.println(destpath);
			
			d=sf.format(new Date());
			ed.createAlbumForUser("profilePicture", userId, d);			//insert into database
			ed.createAlbumForUser("coverPicture", userId, d);
			ed.createAlbumForUser("timeline", userId, d);
			
			addActionMessage("Registration successful.Please check your email and verify your identity.");
			return "success";
		}
		addActionError("Your email is already registered.Please use different Email id.");
		return "error";
	}
	public String forgotPassword(){
		SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String d=sf.format(new Date());
		RegistrationDAO rd=new RegistrationDAOImpl();
		String userId=rd.getUser(email);
		ValidateEmail ve=new ValidateEmail();
		Random randomGenerator = new Random();
		Integer randomInt = randomGenerator.nextInt(1000000);
		NewsFeedDAOImpl nd=new NewsFeedDAOImpl();
		String message="Hi "+nd.getFullUserName(userId)+",\n\n"+"It seems you forgot your password.You have requested for new password.\nPlease find your new password : "+randomInt.toString()+"\n\n\n";
		String subject="Password changed for your facebook account.";
		ve.sendMail(email, message, subject);
		
		boolean res=rd.updatePassword(email, randomInt.toString());
		if(res){
			addActionMessage("New password has been successfully sent on your email.You can always change the password by going in to your account setting.");
			return "success";
		}
		else{
			addActionMessage("Some error occurred.Please try again.");
			return "error";
		}
	}
	public String verifyMail(){
		RegistrationDAO rg=new RegistrationDAOImpl();
		boolean res=rg.verifyUser(email);
		if(res){
			addActionMessage("Your verfication is complete.Now you can login by entering your email and password.");
			
			return "success";
		}else{
			addActionError("Some Error Occurred.Please try again.");
			return "error";
		}
			
	}
	
	
}
