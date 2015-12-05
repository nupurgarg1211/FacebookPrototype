package org.iiitb.facebook.dao;

import java.util.List;
import java.util.Map;

import org.iiitb.facebook.model.User;
import org.iiitb.facebook.model.UserSearch;

/**
 * @author nitin 
 * @fileName SearchDAO.java 
 * @created on 08-Apr-2015
 */
public interface SearchDAO {
	
	public List<UserSearch> search(String term);
	public Map<String, List> searchAll(String searchTerm);
}
