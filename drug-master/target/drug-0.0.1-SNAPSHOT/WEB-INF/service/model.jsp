<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>医药信息管理系统</title>
	<script src="<%=basePath%>static-res/js/jquery.js"></script>
	<link href="<%=basePath%>static-res/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="<%=basePath%>static-res/css/index_css.css" rel="stylesheet">
	<script src="<%=basePath%>static-res/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
  </head>
  <style>
	  body {
		  background-image: url('<%=basePath%>static-res/images/01.jpg');
		  background-size: cover;
		  background-repeat: no-repeat;
		  background-attachment: fixed;
	  }
  </style>

  <body>
  <c:if test="${empty sessionScope.login }">
  		<script type="text/javascript">
  			window.location.href = "<%=basePath%>index.jsp";
  		</script>
  </c:if>
	<div class="container">
		<div class="row"></div>
		<div class="row"></div>
	</div>
</body>
</html>
