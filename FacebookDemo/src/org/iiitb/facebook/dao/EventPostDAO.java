package org.iiitb.facebook.dao;

public interface EventPostDAO {
		public boolean postOnWall(String postDesc,String userFrom,String userTo,String postDate,String picName);
}
