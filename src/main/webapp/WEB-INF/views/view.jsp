<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 보기</title>
</head>
<style>
table#tblView {
	border-collapse:collapse;
}
table#tblView td {
	border: 1px solid blue;	
}
table#tblView th {
	color: white;
	background-color: black;
	border: 1px solid yellow;
}
</style>
<body>
<input type=hidden id=bbs_id value='${post.bbs_id}'>
<table>

<tr>
<td colspan=2>
	<table id=tblView >
	<tr><td>제목</td><td>${post.title}</td></tr>
	<tr><td>내용</td><td>${post.content}</td></tr>
	<tr><td>작성자</td><td>${post.writer}</td></tr>
	<input type=hidden id=passcode value='${post.passcode}'>
	<tr><td>작성시각</td><td>${post.created}</td></tr>
	<tr><td>수정시각</td><td>${post.updated}</td></tr>
	</table>
</td>
</tr>
<tr>
<c:if test="${loggined eq '0'}">
	<td><input type=button id=btnUpdate value='수정'></td>
	<td><input type=submit id=btnDelete value='삭제'></td>
</c:if>
</tr>
<c:if test="">
<tr id=curTR>
	<td>
		<table>
		<tr>
			<td><textarea rows=5 cols=60 id=reply_content></textarea></td>
			<td id=btnAddReply style='background-color:grey'>댓글등록</td>
		</tr>
		</table>
	</td>
</tr>
</c:if>

</table>

</body>
<script src= "https://code.jquery.com/jQuery-3.5.0.js"></script>
<script>
$(document)
.on('click','#btnUpdate',function(){
	var check = confirm('정말로 수정하시겠습니까?');
	if(check) {
		let bbs_id = $('#bbs_id').val();
		document.location="/app/update_view/"+bbs_id;
	} else {
		// no
	}
	return false;
})
.on('click','#btnDelete',function(){
	var check = prompt("비밀번호를 확인해주세요");
	if(check == $('#passcode').val()) {
		let bbs_id = $('#bbs_id').val();
		document.location="/app/delete/"+bbs_id;
	} else {
		alert("비밀번호가 일치하지 않습니다");
	}
	/* var check = confirm('정말로 삭제하시겠습니까?');
	if(check) {
		let bbs_id = $('#bbs_id').val();
		document.location="/app/delete/"+bbs_id;
	} else {
		// no
	} */
	
	return false;
})
.on('click','#btnReply',function(){
	let bbs_id = $('#bbs_id').val();
	document.location="/app/ReplyControl"+bbs+id;
})
</script>
</html>