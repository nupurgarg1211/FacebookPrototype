<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="org.iiitb.facebook.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Dummy</title>
<%
		String user_id = (String)request.getAttribute("user_id");
		String albumId = request.getAttribute("albumId").toString();
		String path = StringUtils.viewImageAction+""+albumId+"&user_id="+user_id;
%>
<script type="text/javascript">
function view()
{
	
	location.replace('<%=path%>');
}
</script>
</head>
<body onload="view()">

</body>
</html>