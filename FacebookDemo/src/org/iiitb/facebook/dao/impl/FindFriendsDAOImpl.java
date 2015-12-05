package org.iiitb.facebook.dao.impl;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.iiitb.facebook.dao.FindFriendsDAO;
import org.iiitb.facebook.model.returnlist_findfriends;
import org.iiitb.facebook.util.ConnectionPool;
import org.iiitb.facebook.util.StringUtils;

public class FindFriendsDAOImpl implements FindFriendsDAO {
	String picPath=StringUtils.RetrivePhotoPath;
	private String profile_pic;
	private ArrayList<String> commonfriends_temp = new ArrayList<String>();
	private ArrayList<String> commonfriends_final_user_id = new ArrayList<String>();
	private ArrayList<String> commonfriends_final_first_name = new ArrayList<String>();
	private ArrayList<String> commonfriends_final_last_name = new ArrayList<String>();
	//private ArrayList<String> peopleyoumayknow = new ArrayList<String>();
	private ArrayList<String> mutualfriends_user_id;
	private ArrayList<String> intersectList;
	private ArrayList<Integer> no_of_mutualfriends = new ArrayList<Integer>();
	//private ArrayList<String> returnlist = new ArrayList<String>();
	private ArrayList<String> mutualfriends_first_name = new ArrayList<String>();
	private ArrayList<String> mutualfriends_last_name = new ArrayList<String>();
	private ArrayList<String> mutualfriends_profile_pic = new ArrayList<String>();
	private ArrayList<returnlist_findfriends> returnlist = new ArrayList<returnlist_findfriends>();
	private Integer number_of_mutualfriends;
	int i=0,j=0,k=0,a=0;
	public ArrayList<returnlist_findfriends> getAllFriends(int user_id) {
		Connection connection = ConnectionPool.getConnection();
		PreparedStatement ps = null;
		PreparedStatement ps1 = null;
		PreparedStatement ps2=null;
		PreparedStatement ps3=null;
		PreparedStatement ps4=null;
		PreparedStatement ps5=null;
		PreparedStatement ps6=null;
		PreparedStatement ps7=null;
		PreparedStatement ps8=null;
		PreparedStatement ps9=null;
		PreparedStatement ps10=null;
		PreparedStatement ps11=null;
		PreparedStatement ps12=null;
		try {
			ps = connection.prepareStatement("select user_id1,user_id2 from user_friends where user_id1='"+user_id+"' "); 
			ResultSet rs = ps.executeQuery();
			System.out.println("user_id== "+user_id);
			//System.out.println("query executed and result set=="+rs);
			while (rs.next()) {
				//System.out.println("rs.getString user_id2== "+rs.getString("user_id2"));
				commonfriends_temp.add(rs.getString("user_id2"));
			}
			
			
			
			/*for(int l=0;l<commonfriends_temp.size();l++)
				System.out.println("in commonfriends_temp== "+commonfriends_temp.get(l));
			*/
			int count=0;
			//System.out.println("commonfriends_temp size=="+commonfriends_temp.size());
			int size=commonfriends_temp.size();
			//System.out.println("size== "+size);
			
			//commonfriends_final_user_id.addAll(commonfriends_temp);
			
			//for calculating friends of friends of given user_id
			for(i=0;i<size;i++){
				if(!(commonfriends_final_user_id.contains(commonfriends_temp.get(i))))
					{
					commonfriends_final_user_id.add(commonfriends_temp.get(i));
					}
				//System.out.println("size of commonfriends_final_user_id.size== "+commonfriends_final_user_id.size());
				//System.out.println("now value of i=="+i);
				count++;
				//System.out.println("now size of commonfriends_final_user_id== "+commonfriends_final_user_id.size());
				//System.out.println("current commonfriend_temp=="+commonfriends_temp.get(i));
				
				//System.out.println("before ps2 commonfriends_temp.get(i)=="+commonfriends_temp.get(i));
				ps2 = connection.prepareStatement("select user_id2,user_id1 from user_friends where user_id2='"+commonfriends_temp.get(i)+"' and user_id1 <> '"+user_id+"'"); 
				ResultSet rs2 = ps2.executeQuery();
				while(rs2.next()){
					//System.out.println("rs2.getString of user_id1=="+rs2.getString("user_id1"));
					
					if(commonfriends_final_user_id.contains(rs2.getString("user_id1"))){
					//System.out.println("already present in commonfriends_final_user_id and value=="+rs2.getString("user_id1"));
					}
					else {
						//System.out.println("not already present in commonfriends_final_user_id and value to be added=="+rs2.getString("user_id1"));
						commonfriends_final_user_id.add(rs2.getString("user_id1"));
						}
				}
				//System.out.println("before ps3 commonfriends_temp.get(i)=="+commonfriends_temp.get(i));
				ps3 = connection.prepareStatement("select user_id2,user_id1 from user_friends where user_id1='"+commonfriends_temp.get(i)+"' and user_id2 <> '"+user_id+"'"); 
				ResultSet rs3 = ps3.executeQuery();
				while(rs3.next()){
					//System.out.println("rs3.getString of user_id2==)"+rs3.getString("user_id2"));
					//mutualfriends_user_id.add(rs2.getString("user_id2"));
					if(commonfriends_final_user_id.contains(rs3.getString("user_id2"))){
					//System.out.println("already present in commonfriends_final_user_id and value=="+rs3.getString("user_id2"));
					}
					else {
						//System.out.println("not already present in commonfriends_final_user_id and value to be added=="+rs3.getString("user_id2"));
						commonfriends_final_user_id.add(rs3.getString("user_id2"));}
				}
				
		
	}//for loop end
			
			//for calculating non-friends of same home town
			ps6 = connection.prepareStatement("select user_id from user_location where city_id=(select city_id from user_location where user_id='"+user_id+"') and user_id <> '"+user_id+"'"); 
			ResultSet rs6 = ps6.executeQuery();
			while(rs6.next()){
				//System.out.println("rs6.getString of user_id==)"+rs6.getString("user_id"));
				//mutualfriends_user_id.add(rs2.getString("user_id1"));
				
				if(commonfriends_final_user_id.contains(rs6.getString("user_id"))){
				//System.out.println("already present in commonfriends_final_user_id and value=="+rs6.getString("user_id"));
				}
				else {
					//System.out.println("not already present in commonfriends_final_user_id and value to be added=="+rs6.getString("user_id"));
					commonfriends_final_user_id.add(rs6.getString("user_id"));
					}
			}
			
			//for calculating non-friends of same education organization or same college
			ps7 = connection.prepareStatement("select user_id from work_education where organization=(select organization from work_education where user_id='"+user_id+"' and type='education') and user_id<> '"+user_id+"'"); 
			ResultSet rs7 = ps7.executeQuery();
			while(rs7.next()){
				//System.out.println("rs7.getString of user_id==)"+rs7.getString("user_id"));
				
				if(commonfriends_final_user_id.contains(rs7.getString("user_id"))){
				//System.out.println("already present in commonfriends_final_user_id and value=="+rs7.getString("user_id"));
				}
				else {
					//System.out.println("not already present in commonfriends_final_user_id and value to be added=="+rs7.getString("user_id"));
					commonfriends_final_user_id.add(rs7.getString("user_id"));
					}
			}
			//System.out.println("size of commonfriends_final_user_id before removing== "+commonfriends_final_user_id.size());
			for(j=0;j<size;j++){
				commonfriends_final_user_id.removeAll(commonfriends_temp);
			}
			
			//System.out.println("value of count=="+count);
			//System.out.println("size of commonfriends_final_user_id=="+size);
			
			ps11 = connection.prepareStatement("select user_to from friends where user_from='"+user_id+"' and request_status='P';");
			ResultSet rs11 = ps11.executeQuery();
			//System.out.println("query executed and result set1=="+rs1);
			
			while (rs11.next()) {
				if(commonfriends_final_user_id.contains(rs11.getString("user_to")))
					commonfriends_final_user_id.remove(rs11.getString("user_to"));
			}
			ps12 = connection.prepareStatement("select user_from from friends where user_to='"+user_id+"' and request_status='P';");
			ResultSet rs12 = ps12.executeQuery();
			//System.out.println("query executed and result set1=="+rs1);
			
			while (rs12.next()) {
				if(commonfriends_final_user_id.contains(rs12.getString("user_from")))
					commonfriends_final_user_id.remove(rs12.getString("user_from"));
			}
			
			
			for(k=0;k<commonfriends_final_user_id.size();k++){
				//System.out.println("commonfriends_final_user_id.get(k)== "+commonfriends_final_user_id.get(k));
				ps8 = connection.prepareStatement("select first_name,last_name from user where user_id='"+commonfriends_final_user_id.get(k)+"'"); 
				ResultSet rs8 = ps8.executeQuery();
				while(rs8.next()){
				//	System.out.println("rs8.getString first_name== "+rs8.getString("first_name"));
					//System.out.println("rs8.getString last_name== "+rs8.getString("last_name"));
					commonfriends_final_first_name.add(rs8.getString("first_name"));
					commonfriends_final_last_name.add(rs8.getString("last_name"));
					
					
				}
		}
			//for calculating mutual friends between 1 and friends of friends
				size=commonfriends_final_user_id.size();
				count=0;
				
				for(i=0;i<size;i++){
				
				mutualfriends_user_id= new ArrayList<String>();
				mutualfriends_first_name= new ArrayList<String>();
				mutualfriends_last_name= new ArrayList<String>();
				count++;
				//System.out.println("show== "+commonfriends_final_user_id.get(i));
				ps4 = connection.prepareStatement("select user_id2,user_id1 from user_friends where user_id2='"+commonfriends_final_user_id.get(i)+"'  "); 
				ResultSet rs4 = ps4.executeQuery();
				while(rs4.next()){
					mutualfriends_user_id.add(rs4.getString("user_id1"));
					
				}
			
				ps5 = connection.prepareStatement("select user_id2,user_id1 from user_friends where user_id1='"+commonfriends_final_user_id.get(i)+"' "); 
				ResultSet rs5 = ps5.executeQuery();
				while(rs5.next()){
					if(!(mutualfriends_user_id.contains(rs5.getString("user_id2"))))
						mutualfriends_user_id.add(rs5.getString("user_id2"));
				}
				System.out.println("size of mutual friends== "+mutualfriends_user_id.size());
				for(int l=0;l<mutualfriends_user_id.size();l++)
					System.out.println("mutual friends user_id== "+mutualfriends_user_id.get(l));
				/*
				count=0;
				//for calculating names of all mutual friends
				/*System.out.println("size of mutual friends== "+mutualfriends_user_id.size());
				for(int l=0;l<mutualfriends_user_id.size();l++)
					System.out.println("mutual friends== "+mutualfriends_user_id.get(l));
				
				for(int l=0;l<commonfriends_temp.size();l++)
					System.out.println("content of commonfriends_temp== "+commonfriends_temp.get(l));
				*/
				intersectList = new ArrayList<String>();

				for (String Value : commonfriends_temp) 
				{
				    if(mutualfriends_user_id.contains(Value)){
				    	System.out.println("Value== "+Value);
				        intersectList.add(Value);
				        }
				}
				/*for(String s: intersectList){
				    System.out.println("mutual friends between 29 and "+commonfriends_final_user_id.get(i)+" is== "+s);
				}
				if(intersectList.size()==0){
					System.out.println("mutual friends between 1 and "+commonfriends_final_user_id.get(i)+" is== 0");
				}
				*/
				
				no_of_mutualfriends.add(intersectList.size());
				
				number_of_mutualfriends=intersectList.size();
				
				for(j=0;j<intersectList.size();j++){
					System.out.println("intersectlist.get(j)== "+intersectList.get(j));
					ps9 = connection.prepareStatement("select first_name,last_name,profile_pic from user where user_id='"+intersectList.get(j)+"'"); 
					ResultSet rs9 = ps9.executeQuery();
					while (rs9.next()) {
						count++;
						mutualfriends_first_name.add(rs9.getString(1));
						mutualfriends_last_name.add(rs9.getString(2));
						
						mutualfriends_profile_pic.add(picPath+"/"+intersectList.get(j)+"_profilePicture"+"/"+rs9.getString("profile_pic"));
					}
					//System.out.println("count=="+count);
				}
				ps10 = connection.prepareStatement("select profile_pic from user where user_id='"+commonfriends_final_user_id.get(a)+"'"); 
				ResultSet rs10 = ps10.executeQuery();
				while (rs10.next()) {
					profile_pic=picPath+"/"+commonfriends_final_user_id.get(a)+"_profilePicture"+"/"+rs10.getString("profile_pic");
				}
			
				returnlist_findfriends rff = new returnlist_findfriends(commonfriends_final_user_id.get(a),commonfriends_final_first_name.get(a),commonfriends_final_last_name.get(a),profile_pic,number_of_mutualfriends,mutualfriends_first_name,mutualfriends_last_name,intersectList,mutualfriends_profile_pic);
				a++;
				returnlist.add(rff);
			}//end of second for
				
		System.out.println("size of return list== "+returnlist.size());	
		a=0;
		/*for(k=0;k<returnlist.size();k++){
			for(a=0;a<returnlist.get(k).getMutualfriends_user_id().size();a++)
			System.out.println("data== "+returnlist.get(k).getUser_id()+" "+returnlist.get(k).getFirst_name()+" "+returnlist.get(k).getLast_name()+" "+returnlist.get(k).getNo_of_mutualfriends()+" "+returnlist.get(k).getMutualfriends_user_id().get(a)+" "+returnlist.get(k).getMutualfriends_first_name().get(a)+" "+returnlist.get(k).getMutualfriends_last_name().get(a));	
		}
		*/
		
	}
			
		
		catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (null != ps) {
				ConnectionPool.freeConnection(connection);
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return returnlist;
		
	}//method end
	public String getProfile_pic() {
		return profile_pic;
	}
	public void setProfile_pic(String profile_pic) {
		this.profile_pic = profile_pic;
	}
	public ArrayList<String> getMutualfriends_profile_pic() {
		return mutualfriends_profile_pic;
	}
	public void setMutualfriends_profile_pic(
			ArrayList<String> mutualfriends_profile_pic) {
		this.mutualfriends_profile_pic = mutualfriends_profile_pic;
	}
	
}//class end