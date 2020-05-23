<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>spring</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
*{
	margin: 0px; padding: 0px;
}
body {
    font-size: 14px;
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
    box-sizing: border-box;  /* padding과 border는 크기에 포함되지 않음 */	
}
a{
	color: #000000;
	text-decoration: none;
	cursor: pointer;
}
a:active, a:hover {
	text-decoration: underline;
	color: tomato;
}
.btn {
    color:#333333;
    font-weight:500;
    border:1px solid #cccccc;
    background-color:#fff;
    text-align:center;
    cursor:cursor;
    padding:3px 10px 5px;
    border-radius:4px;
}
.btn:active, .btn:focus, .btn:hover {
	 background-color:#e6e6e6;
	 border-color: #adadad;
	 color: #333333;
}
.boxTF {
    border:1px solid #999999;
    padding:4px 5px 5px;
    border-radius:4px;
    background-color:#ffffff;
}
.selectField {
    border:1px solid #999999;
    padding:2px 5px 6px;
    border-radius:4px;
    font-size: 12px;
}
.title {
	width:100%;
	height:45px;
	line-height:45px;
	text-align:left;
	font-weight: bold;
	font-size:15px;
}
input:focus, textarea:focus {
	outline: none;
}
</style>

<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>

<script type="text/javascript">

</script>

</head>
<body>

<div style="width: 600px; margin: 30px auto 0px;">
	<div class="title">
	   <h3><span>|</span> 회원 가입</h3>
	</div>
	
	<div>
		<form name="memberForm" method="post">
			<table style="margin: 15px auto 10px; width: 100%; border-spacing: 0px; border-collapse: collapse;">
			
			<tr height="40" style="border-top: 2px solid #507CD1;">
				<td width="100" align="center" bgcolor="#E6E6E6">아&nbsp;이&nbsp;디</td>
				<td align="left" style="padding-left: 5px;">
					<input type="text" name="userId" id="userId"  size="25" maxlength="10"  class="boxTF">
						  <span id="userIdState" style='display:none;'></span>
				</td>
			</tr>
		
			<tr height="40" style="border-top: 1px solid #cccccc;">
				<td width="100" align="center" bgcolor="#E6E6E6">패스워드</td>
				<td align="left" style="padding-left: 5px;">
					<input type="password" name="userPwd" class="boxTF" size="25" maxlength="10">
				</td>
			</tr>
		
			<tr height="40" style="border-top: 1px solid #cccccc;">
				<td width="100" align="center" bgcolor="#E6E6E6">패스워드 확인</td>
				<td align="left" style="padding-left: 5px;">
					<input type="password" name="userPwd1" class="boxTF" size="25" maxlength="10">
				</td>
			</tr>
		
			<tr height="40" style="border-top: 1px solid #cccccc;">
				<td width="100" align="center" bgcolor="#E6E6E6">이&nbsp;&nbsp;&nbsp;&nbsp;름</td>
				<td align="left" style="padding-left: 5px;">
					<input type="text" name="userName" size="25" maxlength="20"  class="boxTF">
				</td>
			</tr>
		
			<tr height="40" style="border-top: 1px solid #cccccc;">
				<td width="100" align="center" bgcolor="#E6E6E6">생년월일</td>
				<td align="left" style="padding-left: 5px;">
					<input type="text" name="birth" size="25" maxlength="20"  class="boxTF">
				</td>
			</tr>
		
			<tr height="40" style="border-top: 1px solid #cccccc;">
				<td width="100" align="center" bgcolor="#E6E6E6">이 메 일</td>
				<td align="left" style="padding-left: 5px;">
						  <select name="selectEmail" id="selectEmail" class="selectField">
								<option value="">선 택</option>
								<option value="naver.com">네이버 메일</option>
								<option value="hanmail.net">한 메일</option>
								<option value="hotmail.com">핫 메일</option>
								<option value="gmail.com">지 메일</option>
								<option value="direct">직접입력</option>
						  </select>
						  <input type="text" name="email1" size="13" maxlength="30"  class="boxTF"> @ 
						  <input type="text" name="email2" size="13" maxlength="30"  class="boxTF" readonly="readonly">
				</td>
			</tr>
			
			<tr height="40" style="border-top: 1px solid #cccccc;">
				<td width="100" align="center" bgcolor="#E6E6E6">전화번호</td>
				<td align="left" style="padding-left: 5px;">
						  <select name="tel1" class="selectField">
								<option value="">선 택</option>
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
						  </select>
						  <input type="text" name="tel2" size="5" maxlength="4"  class="boxTF"> -
						  <input type="text" name="tel3" size="5" maxlength="4"  class="boxTF" >
				</td>
			</tr>
		
			<tr height="40" style="border-top: 1px solid #cccccc;">
				<td width="100" align="center" bgcolor="#E6E6E6">우편번호</td>
				<td align="left" style="padding-left: 5px;">
					<input type="text" name="zip" size="25" maxlength="7"  class="boxTF" readonly="readonly">
					<button type="button" class="btn">우편번호검색</button>
				</td>
			</tr>
			
			<tr height="70" style="border-top: 1px solid #cccccc;">
				<td width="100" align="center" bgcolor="#E6E6E6" valign="top" style="padding-top: 10px;">
				주&nbsp;&nbsp;&nbsp;&nbsp;소
				</td>
				<td align="left" style="padding-left: 5px;">
					<span style="display: block; margin-top: 5px;">
						<input type="text" name="addr1" maxlength="50"  class="boxTF"  readonly="readonly" style="width: 96%;">
					</span>
					<span style="display: block; margin-top: 5px; margin-bottom: 5px;">
						<input type="text" name="addr2" maxlength="50"  class="boxTF" style="width: 96%;">
					</span>
				</td>
			</tr>
			
			<tr height="40" style="border-top: 1px solid #cccccc;">
				<td width="100" align="center" bgcolor="#E6E6E6">직&nbsp;&nbsp;&nbsp;&nbsp;업</td>
				<td align="left" style="padding-left: 5px;">
					<input type="text" name="job" size="25" maxlength="7" class="boxTF">
				</td>
			</tr>
		
			<tr height="50" style="border-top: 2px solid #507CD1;">
				<td align="center" colspan="2">
				    <button type="button" class="btn"> 회원가입 </button>
				    <button type="reset" class="btn"> 다시입력 </button>
				    <button type="button" class="btn"> 가입취소 </button>
				</td>
			</tr>
			
			<tr height="40">
				<td align="center" colspan="2">
					<span style="color: blue;"></span>
				</td>
			</tr>
			</table>
		</form>
	
	</div>
</div>

</body>
</html>