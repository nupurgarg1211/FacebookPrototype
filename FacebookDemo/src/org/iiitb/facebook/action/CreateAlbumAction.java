package org.iiitb.facebook.action;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.iiitb.facebook.dao.AlbumDAO;
import org.iiitb.facebook.dao.RegistrationDAO;
import org.iiitb.facebook.dao.impl.AlbumDAOImpl;
import org.iiitb.facebook.dao.impl.RegistrationDAOImpl;
import org.iiitb.facebook.model.User;
import org.iiitb.facebook.util.PhotoUtil;
import org.iiitb.facebook.util.ValidateEmail;

import com.opensymphony.xwork2.ActionSupport;

public class CreateAlbumAction extends ActionSupport
{	
	public String album_name;
	
	public String getAlbum_name() {
		return album_name;
	}

	public void setAlbum_name(String album_name) {
		this.album_name = album_name;
	}

	public String createAlbum()
	{
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		
		SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date=sf.format(new Date());
		
		AlbumDAO adao = new AlbumDAOImpl();
		boolean res=adao.createAlbum(album_name,u.getUserId(),date);
		if(res)
		{
			PhotoUtil.createAlbum(u.getUserId(), album_name);
			addActionMessage("Album Created.");
			return SUCCESS;
		}
		addActionError("Technical Issue. Try Later.");
		return ERROR;
		
	}
}
