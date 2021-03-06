 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "bbs.Bbs" %>
<%@ page import = "bbs.BbsDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content = "text/html; charset=UTF-8">
<meta name = "viewport" content ="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP Board</title>
</head> 
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
		}
		int bbsID =0;
		if (request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		
		if (bbsID == 0){
			PrintWriter script = response.getWriter(); 
			script.println("<script>");
			script.println("alert('invalid post')"); 
			script.println("location.href = 'bbs .jsp'");
			script.println("</script>");
		}
		
		Bbs bbs= new BbsDAO().getBbs(bbsID);
	%>

	<nav class ="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class = "navbar-toggle collapsed" 
			data-toggle = "collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded ="false">
				<span class ="icon-bar"></span>
				<span class ="icon-bar"></span>
				<span class ="icon-bar"></span> 
			</button>
			<a class="navbar-brand" href="main.jsp">JSP Board</a>
		</div>
		
		
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">MAIN</a></li>
				<li class ="active"><a href="bbs.jsp">BOARD</a></li>
			</ul> 
			
			
		<%
			if (userID == null){ // if user haven't logged in yet
		%>
			<ul class="nav navbar-nav navbar-right">
				<li class ="dropdown">
					<a href="#" class="dropdown-toggle" 
					data-toggle="dropdown" role= "button" aria-haspopup="true"
					aria-expanded="false">CONNECT<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li ><a href="login.jsp">LOGIN</a></li>
						<li><a href="join.jsp">SIGN IN</a></li>
					</ul>
				</li>
		</ul>
		<%
			} else {
		%>
			<ul class="nav navbar-nav navbar-right">
				<li class ="dropdown">
					<a href="#" class="dropdown-toggle" 
					data-toggle="dropdown" role= "button" aria-haspopup="true"
					aria-expanded="false">MANAGE USER<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li ><a href="logoutAction.jsp">LOGOUT</a></li>
					</ul>
				</li>
		</ul>
		<% 
			}		
		%>
		
	</div>
</nav>
 <div class ="container">
 	<div class ="row">
 	
 		<table class ="table table-striped" style ="text-align: center; border: 1px solid #dddddd">
 			<thead>
 				<tr>
 					<th colspan ="3" style ="background-color:#eeeeee; text-align: center;">view the post</th>
 				
 				</tr>
 			</thead>
 			
 			<tbody>
 				<tr>
 					<td style ="width:20%;"> Title </td>
 					<td colspan ="2"><%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>")%> </td>
 				</tr>
 				<tr>
 					<td > UserID </td>
 					<td colspan ="2"><%= bbs.getUserID()%> </td>
 				</tr>
 				<tr>
 					<td > Date </td>
 					<td colspan ="2"><%= bbs.getBbsDate().substring(0,11) + bbs.getBbsDate().substring(11,13) + "hour" + 
 						bbs.getBbsDate().substring(14,16) +"minute"%> </td>
 				</tr>
 				<tr>
 					<td > Content  </td>
 					<td colspan ="2" style ="min-height:200px; text-align:left;"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>")%> </td>
 				</tr>
 			</tbody>
  		</table>
  		<a href ="bbs.jsp" class = "btn btn-primary">list</a>
  		<% //if user == writer, can access update/delete 
  			if (userID != null && userID.equals(bbs.getUserID())){
  		%>		
  			<a href = "update.jsp?bbsID=<%= bbsID%>" class= "btn btn-primary">update</a>
  			<a onclick="return confirm('Are you absolutely sure?  ')" href = "deleteAction.jsp?bbsID=<%= bbsID%>" class= "btn btn-primary">delete</a>
  		<% 	} 
  		%>		
  		
  		<input type ="submit" class = "btn btn-primary pull-right" value = "write">
 
 	</div>
 
 </div>

<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src = "js/bootstrap.js"></script>

</body>
</html>