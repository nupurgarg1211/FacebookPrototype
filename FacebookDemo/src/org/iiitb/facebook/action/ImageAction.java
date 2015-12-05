package org.iiitb.facebook.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @author nitin 
 * @fileName ImageAction.java 
 * @created on 11-Apr-2015
 */
public class ImageAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private String path;

	public String execute()  {
		try {
			HttpServletResponse response = ServletActionContext.getResponse();
			HttpServletRequest request = ServletActionContext.getRequest();
			response.setContentType("image/jpeg");
			System.out.println("Path---->"+path);
			File file = new File(request.getRealPath("/")+getPath());
			InputStream in = new FileInputStream(file);
		    OutputStream out = response.getOutputStream();
		    byte[] buffer = new byte[1024];
		    int len;
		    while ((len = in.read(buffer)) != -1) {
		      out.write(buffer, 0, len);
		    }
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return NONE;
	}
	
	/**
	 * @return the path
	 */
	public String getPath() {
		return path;
	}

	/**
	 * @param path the path to set
	 */
	public void setPath(String path) {
		this.path = path;
	}
}
