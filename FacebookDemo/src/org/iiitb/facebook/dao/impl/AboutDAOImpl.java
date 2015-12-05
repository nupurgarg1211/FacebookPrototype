package org.iiitb.facebook.dao.impl;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.ArrayList;
import java.util.List;

import org.iiitb.facebook.model.*;
import org.iiitb.facebook.util.ConnectionPool;
import org.iiitb.facebook.dao.AboutDAO;


public class AboutDAOImpl implements AboutDAO
{
	
	public ArrayList<Relationship> getRelations()
	{
		Connection con = ConnectionPool.getConnection();
		ArrayList<Relationship> list_relations = new ArrayList<Relationship>();
		Relationship r = new Relationship();
		r.setRelationship_id("");
		r.setRelationship_name("");
		list_relations.add(r);
		String sql = "select * from relationship";
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
				r = new Relationship();
				r.setRelationship_id(rs.getString("relationship_id"));
				r.setRelationship_name(rs.getString("relationship_name"));
				list_relations.add(r);
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(con);
		}
		return list_relations;
	}
	public About about_details(String user_id)
	{
		Connection con = ConnectionPool.getConnection();
		About about = new About();
		String sql = "select user_id,first_name,last_name,mobile_no,dob,gender,current_city,hometown,address,relationship_status from user where user_id = ?";
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, user_id);
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
				about.setUser_id(rs.getString("user_id"));
				about.setFirst_name(rs.getString("first_name"));
				about.setLast_name(rs.getString("last_name"));
				about.setGender(rs.getString("gender"));
				about.setDob(rs.getString("dob"));
				about.setMobile(rs.getString("mobile_no"));
				about.setCurrent_city(rs.getString("current_city"));
				about.setHometown(rs.getString("hometown"));
				about.setAddress(rs.getString("address"));
				about.setRelationship(rs.getString("relationship_status"));
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(con);
		}
		return about;
	}
	
	public ArrayList<Work> work_details(String user_id)
	{
		Connection con = ConnectionPool.getConnection();
		ArrayList<Work> list_work = new ArrayList<Work>();
		String sql = "select user_id,we_id,organization,position,start_date,end_date from work_education where type=\"work\" and user_id = ?";
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, user_id);
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
				Work w = new Work();
				w.setUser_id(rs.getString("user_id"));
				w.setWe_id(rs.getString("we_id"));
				w.setCompany_name(rs.getString("organization"));
				w.setPosition(rs.getString("position"));
				w.setStart_date(rs.getString("start_date"));
				w.setEnd_date(rs.getString("end_date"));
				list_work.add(w);
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(con);
		}
		return list_work;
	}
	
	public ArrayList<Education> education_details(String user_id)
	{
		Connection con = ConnectionPool.getConnection();
		ArrayList<Education> list_education = new ArrayList<Education>();
		String sql = "select user_id,we_id,organization,position,start_date,end_date from work_education where type=\"education\" and user_id = ?";
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, user_id);
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
				Education e = new Education();
				e.setUser_id(rs.getString("user_id"));
				e.setWe_id(rs.getString("we_id"));
				e.setInstitution_name(rs.getString("organization"));
				e.setStudied(rs.getString("position"));
				e.setStart_date(rs.getString("start_date"));
				e.setEnd_date(rs.getString("end_date"));
				list_education.add(e);
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(con);
		}
		return list_education;
	}
	public void update_about_details(String user_id, String first_name, String last_name, String gender,String dob, String mobile,String current_city,String hometown,String address,String relationship)
	{
		Connection con = ConnectionPool.getConnection();
		String sql;
		if(dob.equals(""))
			dob = null;
		if(relationship.equals(""))
			relationship = null;
		sql = "update user set first_name = ?,last_name = ?,gender = ?,dob = ?,mobile_no = ?,current_city=?,hometown=?,address=?,relationship_status=? where user_id = ?";
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, first_name);
			ps.setString(2, last_name);
			ps.setString(3, gender);
			ps.setString(4, dob);
			ps.setString(5, mobile);
			ps.setString(6, current_city);
			ps.setString(7, hometown);
			ps.setString(8, address);
			ps.setString(9, relationship);
			ps.setString(10, user_id);
			ps.executeUpdate();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(con);
		}
	}
	
	public void update_we_details(String we_id, String organization, String position, String start_date,String end_date)
	{
		Connection con = ConnectionPool.getConnection();
		String sql;
		if(start_date.equals(""))
			start_date = null;
		if(end_date.equals(""))
			end_date = null;
		sql = "update work_education set organization = ?,position = ?,start_date = ?,end_date = ? where we_id = ?";
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, organization);
			ps.setString(2, position);
			ps.setString(3, start_date);
			ps.setString(4, end_date);
			ps.setString(5, we_id);
			ps.executeUpdate();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(con);
		}
	}
	public WorkEducation get_we_details(String we_id)
	{
		Connection con = ConnectionPool.getConnection();
		WorkEducation we = new WorkEducation();
		String sql = "select user_id,organization,position,start_date,end_date from work_education where we_id = ?";
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, we_id);
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
				we.setUser_id(rs.getString("user_id"));
				we.setOrganization(rs.getString("organization"));
				we.setPosition(rs.getString("position"));
				we.setStart_date(rs.getString("start_date"));
				we.setEnd_date(rs.getString("end_date"));
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(con);
		}
		return we;
	}
	
	public boolean addWorkEducation(String userId,String type,String organization,String position,String start_date,String end_date)
	{
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		if(start_date.equals(""))
			start_date = null;
		if(end_date.equals(""))
			end_date = null;
		String sql="insert into work_education(user_id,type,organization,position,start_date,end_date) values(?,?,?,?,?,?)";
		try
		{
			preStmt = conn.prepareStatement(sql);
			preStmt.setString(1,userId);
			preStmt.setString(2,type);
			preStmt.setString(3,organization);
			preStmt.setString(4,position);
			preStmt.setString(5,start_date);
			preStmt.setString(6,end_date);
			int n=preStmt.executeUpdate();
			if(n>0){
				return true;
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return false;
	}
	public boolean deleteWorkEducation(String we_id)
	{
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		String sql="delete from work_education where we_id = ?";
		try
		{
			preStmt = conn.prepareStatement(sql);
			preStmt.setString(1,we_id);
			int n=preStmt.executeUpdate();
			if(n>0){
				return true;
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return false;
	}
}
