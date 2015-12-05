package org.iiitb.facebook.util;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ConnectionPool
{

	private static DataSource datasource;

	public static DataSource getDatasource()
	{
		return datasource;
	}

	public static void setDatasource(DataSource datasource)
	{
		ConnectionPool.datasource = datasource;
	}

	public static Connection getConnection()
	{

		Connection conn = null;
		try
		{
			if (datasource != null)
			{
				conn = datasource.getConnection();
			}
			else
			{
				Context context = new InitialContext();

				datasource = (DataSource) context.lookup("java:comp/env/jdbc/facebookdb");

				conn = datasource.getConnection();

			}

		}

		catch (SQLException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		catch (NamingException e)
		{

			e.printStackTrace();
		}
		return conn;

	}

	public static void freeConnection(Connection conn)
	{
		try
		{
			conn.close();
		}
		catch (SQLException e)
		{

			e.printStackTrace();
		}
	}

}
