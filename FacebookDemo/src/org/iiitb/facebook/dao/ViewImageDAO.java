package org.iiitb.facebook.dao;

import java.util.ArrayList;

import org.iiitb.facebook.model.Image;

public interface ViewImageDAO {
	
	public ArrayList<Image> getImages(int albumId);

}
