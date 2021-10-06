<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정하기</title>
</head>
<body>
<form method=POST id=frmUpdate action="/app/update">
<table>
<input type=hidden id=bbs_id name=bbs_id1 value='${post.bbs_id}'>
<tr><td>제목</td><td><input type=text name=title value="${post.title}"></td></tr>
<tr><td valign=top>내용</td>
   <td><textarea name=content rows=20 cols=60>${post.content}</textarea></td></tr>
<tr><td>작성자</td><td><input type=text name=writer value="${post.writer}" disabled></td></tr>
<input type=hidden id=passcode value='${post.passcode}'>
<tr><td>비밀번호확인</td><td><input type=password id=passCheck name=passcode></td></tr>
<tr><td colspan=2><input type=submit id=checkPass value='글 수정'>&nbsp;
   <input type=button value='취소(목록보기)' id=btnCancel>
</table>
</form>
</body>
<script src="https://code.jquery.com/jQuery-3.5.0.js"></script>
<script>
$(document)
.on('submit','#frmUpdate',function(){
	if($('#passCheck').val() == $('#passcode').val()) {
		return true;
	} else {
		alert("비밀번호를 확인해주세요.");
		return false;
	}
})
.on('click','#btnCancel',function(){
	document.location='/app/list';
	return false;
})
</script>
</html>