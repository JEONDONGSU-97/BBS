<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<style>
table#tblList {
	border-collapse:collapse;
}
table#tblList td {
	border: 1px solid blue;
}
table#tblList th {
	color: white;
	background-color:black;
	border: 1px solid yello;
}
</style>

<table>
<tr><td>
<c:if test="${loggined eq '0'}">
	<input type=button value='로그인' id=btnLogin>
</c:if>

</td></tr>
<tr><td>
	<table id=tblList>
	<thead>
	<tr><th>게시물번호</th><th>제목</th><th>작성자</th><th>작성시각</th><th>수정시각</th></tr>
	</thead>
	<tbody>
	<c:forEach var="rec" items="${list_BBS}">
		<tr><td>${rec.bbs_id}</td><td>${rec.title}</td><td>${rec.writer}</td><td>${rec.created}</td><td>${rec.updated}</td></tr>
	</c:forEach>
	</tbody>
	</table>
</td></tr>

<tr><td>
<c:if test="${loggined eq '1'}">
	<input type="button" value="새글쓰기" id=btnNew>
	<input type="button" value="로그아웃" id=btnLogOut>
	<input type="hidden" id=replyUserId>
	${userid}님 반갑습니다.
</c:if>
</td></tr>

</table>

</body>
<script src= "https://code.jquery.com/jQuery-3.5.0.js"></script>
<script>
$(document)
.on('click','#btnLogin', function(){
	document.location="/app/login";
	return false;
})
.on('click','#tblList tr',function(){
	let bbs_id = $(this).find('td:eq(0)').text();
	console.log('bbs_id ['+bbs_id+']');
	document.location="/app/view/"+bbs_id; // "http://localhost:8081/app/view/2"
	return false;
})
.on('click','#btnNew',function(){
	document.location="/app/new";
	return false;
})
.on('click','#btnLogin',function(){
	document.location='/app/login';
	return false;
})
.on('click','#btnLogOut',function(){
	if(confirm("정말로 로그아웃 하시겠습니까?")) {
		document.location='/app/logout';
		return true;
	}
	else {
		return false;
	}
})
</script>
</html>