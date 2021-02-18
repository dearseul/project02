<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"
    import="jspexp.z01_vo.*"%>
<% request.setCharacterEncoding("UTF-8");
String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- path기준으로 모든 자원(css,img,js)를 접근하여 사용할 수 있다. --%>
<link rel="stylesheet" href="<%=path %>/a01_sign/reset.css"> 
<title>Insert title here</title>
<style>
html, body
{
    height: 100%;
}

body
{
    display: table;
    margin: 0 auto;
}

.main
{
    height: 200px;
    width: 200px;
    background-color: blue;     
}

#loginbox
{
    height: 100%;
    display: table-cell;
    vertical-align: middle;
}
#login_text{
	text-align:center;
	font-size:20px; 
	margin-bottom:20px;
}

#input_id, #input_pass{
	width:250px; 
	height:50px;
}

#search_id{
	display:inline-block;
	widgh:120px;
	height:10px;
	font-size:14px;
	padding:0px 0px 0px 110px;
	margin-top:20px;
	margin-bottom:15px;
}
#search_pass
{
	display:inline-block;
	widgh:120px;
	height:10px;
	font-size:14px;
	padding:0px 0px 0px 10px;
}
#input_login, #input_signUp{
	margin-bottom:10px;
	width:258px; 
	height:50px; 
	color: white; 
	background-color:#334858; 
	border-color:#334858;
}
</style>
<script>
	window.onload=function(){

	};
</script> 
</head>
 <%
		String id = request.getParameter("id");
		String pass= request.getParameter("pass");
		if(id!=null && pass!=null){
				if(id.equals("admin")){
					session.setAttribute("id",id);
					response.sendRedirect("admin01.jsp");
				}else{
					session.setAttribute("id",id);
					response.sendRedirect("main.jsp");
				}
		}  
%>
<body>
	<div id ="loginbox">
		<div id="login_text">로그인</div>
		<form id="frm" method="post">
			<input id="input_id" type="text" name="id" value="아이디" onfocus="this.value=''" ><br>
			<input id="input_pass" type="text" name="pass" value="비밀번호" onfocus="this.value=''; type='password';">
			<div id="search">
				<p id="search_id" onclick="searchId()">아이디찾기</p>
				<p id="search_pass" onclick="searchPass()">비밀번호찾기</p>
			</div>
			<!-- search -->
			<input id="input_login" type="button" value="로그인" onclick="login1()"> <br>
			<input id="input_signUp" type="button" value="회원가입" onclick="signUp()" >
		</form>
	</div>
	<!-- loginbox -->
</body>

				
<script>
	function login1(){
		var id = document.querySelector("[name=id]").value;
		var pass = document.querySelector("[name=pass]").value;
		var frm = document.querySelector("#frm");
		if(id=='아이디'|id==''){
			alert('아이디를 입력해주세요');
		}else if(pass=='비밀번호'|pass==''){
			alert('비밀번호를 입력해주세요');
		}else{
			if(id=='admin'){
				frm.submit();
				
			}else{
				frm.submit();
				
			}
		}
	}
	
	
	function signUp(){
		location.href="signUp.jsp";
	}
	function searchId(){
		location.href="searchId.jsp";
	}
	function searchPass(){
		location.href="searchPass.jsp";
	}
</script>
</html>