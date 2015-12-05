package org.iiitb.facebook.action;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;
import javax.xml.bind.DataBindingException;

import org.apache.struts2.ServletActionContext;
import org.iiitb.facebook.model.User;
import org.iiitb.facebook.model.UserDhruvik;
import org.iiitb.facebook.util.ConnectionPool;
import org.iiitb.facebook.util.StringUtils;

public class dobAction {

	ArrayList<UserDhruvik> al;
	
	public String dob(){
		al = new ArrayList<UserDhruvik>();
		
		String picPath = StringUtils.photoPath;
		
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		String st = u.getUserId();
		
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
    	Date dateobj = new Date();
		
		//System.out.println(d.getDate());
		Connection conn = ConnectionPool.getConnection();
		String sql="select user_id,first_name,last_name,profile_pic,dob from user where user_id in ( select user_id1 from user_friends where user_id2 = ?) and user_id <> ?";
		PreparedStatement ps = null;
		try {
			 
			ps = conn.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(st));
			ps.setInt(2, Integer.parseInt(st));
		
			
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				UserDhruvik user = new UserDhruvik();
				//user.setName(rs.getString("first_name") + " "
					//	+ rs.getString("last_name"));
				user.setUserid(rs.getInt("user_id"));
				user.setFirst_name(rs.getString("first_name"));
				user.setLast_name(rs.getString("last_name"));
				user.setUserid(rs.getInt("user_id"));
				user.setProfile_pic(picPath+"/"+user.getUserid()+"_profilePicture"+"/"+rs.getString("profile_pic"));
				if(df.format(dateobj).toString().contains(rs.getString("dob").substring(5))){
				al.add(user);
				}
			}
			
			System.out.println("==============> "+al.size());
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			
				ConnectionPool.freeConnection(conn);
		}
		
		return "success";
		
	}

	public ArrayList<UserDhruvik> getAl() {
		return al;
	}

	public void setAl(ArrayList<UserDhruvik> al) {
		this.al = al;
	}
	
}
