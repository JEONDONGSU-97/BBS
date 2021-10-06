<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새글쓰기</title>
</head>
<body>
<form method=POST action="/app/save">
<table>
<tr><td>제목</td><td><input type=text name=title required></td></tr>
<tr><td valign=top>내용</td>
   <td><textarea name=content rows=20 cols=60 required></textarea></td></tr>
<tr><td>작성자</td><td><input type=text name=writer required></td></tr>
<tr><td>비밀번호</td><td><input type=password name=passcode required></td></tr>
<tr><td colspan=2><input type=submit value='글 등록'>&nbsp;
   <input type=button value='취소(목록보기)' id=btnCancel>
</table>
</form>
</body>
<script src="https://code.jquery.com/jQuery-3.5.0.js"></script>
<script>
$(document)
.on('click','#btnCancel',function(){
	document.location='/app/list';
	return false;
})
</script>
</html>