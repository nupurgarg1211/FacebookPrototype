package org.iiitb.facebook.dao;

import java.util.ArrayList;


import org.iiitb.facebook.model.About;
import org.iiitb.facebook.model.Education;
import org.iiitb.facebook.model.Relationship;
import org.iiitb.facebook.model.Work;
import org.iiitb.facebook.model.WorkEducation;

public interface SettingDAO
{
	public About getSetting(String user_id);
	public boolean saveSetting(String user_id,String first_name, String last_name, String dob, String password);
}
