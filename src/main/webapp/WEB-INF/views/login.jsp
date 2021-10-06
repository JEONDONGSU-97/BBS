<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
<form id=frmLogin method="post" action="/app/login_check">
<table style='border-collapse:collapse, border:1px solid black'>
<tr>
	<td align=right style='border:1px solid black'>로그인아이디</td><td><input type=text name=loginid required></td>
</tr>
<tr>
	<td align=right style='border:1px solid black'>비밀번호</td><td><input type=password name=passcode required></td>
</tr>
<tr>
	<td align=center colspan=2 style='border:1px solid black'>
		<input type="submit" value='로그인'>
		<input type="reset" value='취소' id=btnReset>
	</td>
</tr>
<tr>
	<td align=center colspan=2 style='border:1px solid black'>
		<input type="button" value='목록보기' id=showList>
		<input type="button" value='회원가입' id=newbie>
	</td>
</tr>
</table>
</form>
</body>
</html>
<script src="https://code.jquery.com/jQuery-3.5.0.js"></script>
<script>
$(document)
.on('click','#newbie',function(){
	document.location="/app/newbie";
	return false;
})
.on('click','#showList',function(){
	document.location="/app/list";
	return false;
})
</script>