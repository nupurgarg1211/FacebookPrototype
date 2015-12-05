package org.iiitb.facebook.util;

import java.io.File;

import org.apache.struts2.ServletActionContext;

public class PhotoUtil {
	
	public static String getOSName(){
		return System.getProperty("os.name");
	}
	public static String getImagePath(){
		String path1="";
		path1=StringUtils.photoPath;		
		return path1;
	}
	public static boolean firstTimeAlbumCreation(String userId){
		File profPic=null;
		File coverPic=null;
		File timeLine=null;
		String path1=getImagePath();
		String os=getOSName();
		if(os.equalsIgnoreCase("Windows 7") || os.equalsIgnoreCase("Windows 8")){
			profPic=new File(path1+"\\"+userId+"_profilePicture");
			coverPic=new File(path1+"\\"+userId+"_coverPicture");
			timeLine=new File(path1+"\\"+userId+"_timeline");
		}else{
			profPic=new File(path1+"/"+userId+"_profilePicture");
			coverPic=new File(path1+"/"+userId+"_coverPicture");
			timeLine=new File(path1+"/"+userId+"_timeline");
		}		
		profPic.mkdir();
		coverPic.mkdir();
		timeLine.mkdir();
		return true;
	}
	
	
	
	public static String groupGetImagePath(){
		String path1="";
		path1=StringUtils.groupPhotoPath;		
		return path1;
	}
	public static boolean groupFirstTimeAlbumCreation(String group_id){
		File profPic=null;
		File coverPic=null;
		File timeLine=null;
		String path1=groupGetImagePath();
		System.out.println("creating folder at "+path1);
		String os=getOSName();
		if(os.equalsIgnoreCase("Windows 7") || os.equalsIgnoreCase("Windows 8")){
			profPic=new File(path1+"\\"+group_id+"_groupPicture");
			coverPic=new File(path1+"\\"+group_id+"_coverPicture");
			timeLine=new File(path1+"\\"+group_id+"_timeline");
			
		}else{
			profPic=new File(path1+"/"+group_id+"_groupPicture");
			coverPic=new File(path1+"/"+group_id+"_coverPicture");
			timeLine=new File(path1+"/"+group_id+"_timeline");
		}		
		profPic.mkdir();
		coverPic.mkdir();
		timeLine.mkdir();
		return true;
	}
	public static String eventGetImagePath(){
		String path1="";
		path1=StringUtils.eventPhotoPath;		
		return path1;
	}
	
	public static boolean eventFirstTimeAlbumCreation(String eventId){
		File profPic=null;
		File coverPic=null;
		
		String path1=eventGetImagePath();
		System.out.println("creating folder at "+path1);
		String os=getOSName();
		if(os.equalsIgnoreCase("Windows 7") || os.equalsIgnoreCase("Windows 8")){
			profPic=new File(path1+"\\"+eventId+"_evtimeline");
			coverPic=new File(path1+"\\"+eventId+"_evcoverPicture");
			
		}else{
			profPic=new File(path1+"/"+eventId+"_evtimeline");
			coverPic=new File(path1+"/"+eventId+"_evcoverPicture");
			
		}		
		profPic.mkdir();
		coverPic.mkdir();
		
		return true;
	}
	
	
	public static void main(String args[]){
		PhotoUtil.firstTimeAlbumCreation("18");
	}
	public static boolean createAlbum(String userId,String albumName)
	{
		File albumPic=null;
		String path1=getImagePath();
		String os=getOSName();
		if(os.equalsIgnoreCase("Windows 7") || os.equalsIgnoreCase("Windows 8")){
			albumPic=new File(path1+"\\"+userId+"_"+albumName);
		}else{
			albumPic=new File(path1+"/"+userId+"_"+albumName);
		}		
		albumPic.mkdir();
		return true;
	}
}
