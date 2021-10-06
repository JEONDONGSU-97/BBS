<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<form method="POST" action="/app/newbie_check" id='frmNew'>
<table style='border-collapse:collapse'>
	<tr><td align=right>이름</td><td><input type=text id=name name='realName' required></td></tr>
	<tr><td align=right>아이디</td><td><input type=text id=loginid name='loginId' required></td></tr>
	<tr><td align=right>비밀번호</td><td><input type=password id=passcode1 name='password' required></td></tr>
	<tr><td align=right>비밀번호확인</td><td><input type=password id=passcode2 name='password1' required></td></tr>
	<tr><td align=center colspan=2>
		<input type=submit value='가입완료' id='btnNew'>
		<input type=reset value='취소'>
		<a href="/app/login">로그인창 가기</a>
	</td></tr>
	
</table>
</form>
</body>
</html>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document)
.on('submit','#frmNew',function(){
	if($('input[name=password]').val()!=$('input[name=password1]').val()) {
		alert("비밀번호가 일치하지 않아요.");
		return false;
	}
/* 	if($('#passcode1').val()!=$('#passcode2').val()){
		alert("비밀번호가 일치하지 않아요.");
		return false;
	} */
});
</script>