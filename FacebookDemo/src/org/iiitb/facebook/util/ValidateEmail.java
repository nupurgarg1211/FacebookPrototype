package org.iiitb.facebook.util;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Properties;

public class ValidateEmail {

	public boolean sendMail(String email_id,String message1,String subject)
	{
		String to = email_id;
		message1=message1+"Auto generated mail. Please do not reply to this mail\n\nThanks,\n\nGroup6\nThe Facebook Team.\n";
		String from = "facebook.iiitb@gmail.com";//change accordingly
	    final String username = "facebook.iiitb@gmail.com";//change accordingly
	    final String password = "Qwerty654321";//change accordingly
	    
	    String host = "smtp.gmail.com";
	    Properties props = new Properties();
	    props.put("mail.smtp.auth", "true");
	    props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
	    props.put("mail.smtp.starttls.enable", "true");
	    props.put("mail.smtp.host", host);
	    props.put("mail.smtp.port","587");
	    
	    Session session = Session.getInstance(props,
	    	      new javax.mail.Authenticator() {
	    	         protected PasswordAuthentication getPasswordAuthentication() {
	    	            return new PasswordAuthentication(username, password);
	    	         }
	    	      });
	    try
	    {
	    	Message message = new MimeMessage(session);
	    	message.setFrom(new InternetAddress(from));
	    	message.setRecipients(Message.RecipientType.TO,
	    	         InternetAddress.parse(to));
	    	message.setSubject(subject);
	    	message.setText(message1);
	    	Transport.send(message);
	    	System.out.println("Sent message successfully....");
	    }
	    catch (MessagingException e) 
	    {
            throw new RuntimeException(e);
	    }
	    return true;
	}  
}
