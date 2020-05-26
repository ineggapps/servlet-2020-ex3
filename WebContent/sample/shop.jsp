<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>spring</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
* {
    margin:0; padding:0;
}

body {
    font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
    font-size: 14px;
}

a {
    cursor: pointer;
    color: #000000;
    text-decoration: none;
    /*line-height: 150%;*/
}
a:hover, a:active {
    color: #F28011;
    text-decoration: underline;
}

.btn {
    color:#333333;
    font-weight:500;
    font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
    border:1px solid #cccccc;
    background-color:#fff;
    text-align:center;
    cursor:pointer;
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
    padding:3px 5px 5px;
    border-radius:4px;
    background-color:#ffffff;
    font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
}
.buyAdd {
	cursor: pointer;
}
.buyAdd:active, .buyAdd:focus, .buyAdd:hover {
    font-weight: 700;
}
.buyCancel{
	cursor: pointer;
}
</style>

<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>

<script type="text/javascript">
$(function(){
	$(".buyAdd").click(function(){
		var totalBuyQty = parseInt($("#totalBuyQty").text());
		var totalBuyAmt = parseInt($("#totalBuyAmt").text());
		
		var title=$(this).parent().parent().children().eq(0).text();
		var code=$(this).attr("data-code");
		var price=parseInt($(this).attr("data-price"));
		var qty=1;
		
		var t="#buyTr"+code;
		if($(t).length) { // 해당 코드가 존재하면
			// qty=$(t).children().children("input[name=quantity]").val();
			qty=$(t+" input[name=quantity]").val();
			if(! qty) qty=0;
			
			pty=parseInt(qty)+1;
			
			$(t+" input[name=quantity]").val(pty);
			$(t+" .productPrice").text(pty*price);
			
			totalBuyQty=totalBuyQty+1;
			totalBuyAmt=totalBuyAmt+price;
			$("#totalBuyQty").text(totalBuyQty);
			$("#totalBuyAmt").text(totalBuyAmt);
		
			return;
		}
		
		var $tr, $td, $input;
		
		var vprice = "<span class='productPrice'>"+price+"</span>원 <span class='buyCancel' data-code='"+code+"' data-price='"+price+"'>×</span>";
	    $tr=$("<tr height='40' style='border-bottom: 1px solid #cccccc;' id='buyTr"+code+"'>");
	    $td=$("<td>", {width:"200", style:"text-align: center;", html:title});
	    $tr.append($td);
	    $td=$("<td width='180' style='text-align: right;'>");
	    $input=$("<input>", {type:"text", name:"quantity", class:"boxTF", style:"width: 30%;", value:qty, readonly:"readonly"});
	    $td.append($input);
	    $input=$("<input>", {type:"button", class:"btn btnPlus", value:"+"});
	    $td.append($input);
	    $input=$("<input>", {type:"button", class:"btn btnMinus", value:"-"});
	    $td.append($input);
	    $input=$("<input>", {type:"hidden", name:"code", value:code});
	    $td.append($input);
	    $tr.append($td);
	    $td=$("<td>", {width:"200", style:"text-align: right; padding-right: 5px;", html:vprice});
	    $tr.append($td);
	    
	    $("#buyList").append($tr);
		
		totalBuyQty=totalBuyQty+1;
		totalBuyAmt=totalBuyAmt+price;
		$("#totalBuyQty").text(totalBuyQty);
		$("#totalBuyAmt").text(totalBuyAmt);
	    
	});
});

$(function(){
	$("body").on("click", ".buyCancel", function(){
		var code=$(this).attr("data-code");
		var price=parseInt($(this).attr("data-price"));
		var t="#buyTr"+code;
		var qty=$(t+" input[name=quantity]").val();
		if(! qty) qty=0;
		
		$(t).remove();
		
		var totalBuyQty = parseInt($("#totalBuyQty").text());
		var totalBuyAmt = parseInt($("#totalBuyAmt").text());
		totalBuyQty=totalBuyQty-parseInt(qty);
		totalBuyAmt=totalBuyAmt-(price*parseInt(qty));
		$("#totalBuyQty").text(totalBuyQty);
		$("#totalBuyAmt").text(totalBuyAmt);
	});
});

$(function(){
	$("body").on("click", ".btnPlus", function(){
		var code=$(this).siblings("input[name=code]").val();
		var price=parseInt($(this).parent().next().children(".buyCancel").attr("data-price"));
		var qty=parseInt($(this).parent().children("input[name=quantity]").val());
		var productPrice=parseInt($(this).parent().next().children(".productPrice").text());
		var totalBuyQty = parseInt($("#totalBuyQty").text());
		var totalBuyAmt = parseInt($("#totalBuyAmt").text());

		qty=qty+1;
		productPrice=productPrice+price;
		$(this).parent().children("input[name=quantity]").val(qty);
		$(this).parent().next().children(".productPrice").text(productPrice);
		
		totalBuyQty=totalBuyQty+1;
		totalBuyAmt=totalBuyAmt+price;
		$("#totalBuyQty").text(totalBuyQty);
		$("#totalBuyAmt").text(totalBuyAmt);
	});

	$("body").on("click", ".btnMinus", function(){
		var code=$(this).siblings("input[name=code]").val();
		var price=parseInt($(this).parent().next().children(".buyCancel").attr("data-price"));
		var qty=parseInt($(this).parent().children("input[name=quantity]").val());
		var productPrice=parseInt($(this).parent().next().children(".productPrice").text());
		var totalBuyQty = parseInt($("#totalBuyQty").text());
		var totalBuyAmt = parseInt($("#totalBuyAmt").text());
		if(qty<=0)
			return;
		
		qty=qty-1;
		productPrice=productPrice-price;
		$(this).parent().children("input[name=quantity]").val(qty);
		$(this).parent().next().children(".productPrice").text(productPrice);
		
		totalBuyQty=totalBuyQty-1;
		totalBuyAmt=totalBuyAmt-price;
		$("#totalBuyQty").text(totalBuyQty);
		$("#totalBuyAmt").text(totalBuyAmt);
	});
});

</script>

</head>

<body>

 <div style="width: 1000px; margin: 30px auto;">
 	<div style="clear: both;">
		<div style="width: 400px; float: left;">
			<table style="width: 100%; border-spacing: 0px; border-collapse: collapse;">
				<tr height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
					<td bgcolor="#eeeeee" style="text-align: center;">상품명</td>
					<td width="150" bgcolor="#eeeeee" style="text-align: center;">금액</td>
					<td width="100" bgcolor="#eeeeee" style="text-align: center;">구매</td>
				</tr>
				<tr height="35" style="border-bottom: 1px solid #cccccc;">
					<td style="text-align: center;">초콜릿</td>
					<td style="text-align: right; padding-right: 5px;"><fmt:formatNumber value="1300"  type="currency"/></td>
					<td style="text-align: center;"><span class="buyAdd" data-code="100" data-price="1300">구매추가</span></td>
				</tr>
				<tr height="35" style="border-bottom: 1px solid #cccccc;">
					<td style="text-align: center;">아메리카노</td>
					<td style="text-align: right; padding-right: 5px;"><fmt:formatNumber value="2200"  type="currency"/></td>
					<td style="text-align: center;"><span class="buyAdd" data-code="101" data-price="2200">구매추가</span></td>
				</tr>
				<tr height="35" style="border-bottom: 1px solid #cccccc;">
					<td style="text-align: center;">콜라</td>
					<td style="text-align: right; padding-right: 5px;"><fmt:formatNumber value="800"  type="currency"/></td>
					<td style="text-align: center;"><span class="buyAdd" data-code="102" data-price="800">구매추가</span></td>
				</tr>
				<tr height="35" style="border-bottom: 1px solid #cccccc;">
					<td style="text-align: center;">새콤달콤</td>
					<td style="text-align: right; padding-right: 5px;"><fmt:formatNumber value="700"  type="currency"/></td>
					<td style="text-align: center;"><span class="buyAdd" data-code="103" data-price="700">구매추가</span></td>
				</tr>
				<tr height="35" style="border-bottom: 1px solid #cccccc;">
					<td style="text-align: center;">아이스크림</td>
					<td style="text-align: right; padding-right: 5px;"><fmt:formatNumber value="500"  type="currency"/></td>
					<td style="text-align: center;"><span class="buyAdd" data-code="104" data-price="500">구매추가</span></td>
				</tr>
			</table>
		</div>
		<div style="width: 580px; float: left; margin-left:20px; padding: 0 5px 5px; box-sizing: border-box;">
		
		    <form name="buyForm" method="post">
		    <table style="width: 100%; border-spacing: 0px; border-collapse: collapse; border: 1px solid #cccccc; background: #eeeeee;">
		        <thead>
			    	<tr height="40" style="border-bottom: 1px solid #cccccc;">
			    		<td colspan="3"><span style="font-weight: 700; padding-left: 10px;">| 구매 리스트</span></td>
			    	</tr>
		    	</thead>
		    	<tbody id="buyList">
		    	</tbody>
		    	<tfoot>
			    	<tr height="40" style="border-top: 1px solid #cccccc;">
			    		<td align="right" colspan="3">
			    		   <span>총수량 : </span><span id="totalBuyQty">0</span>개 | 
			    		   <span style="font-weight: 700;">총 상품금액 : </span><span id="totalBuyAmt" style="font-weight: 900; color: #2eb1d3; font-size: 17px;">0</span>
			    		   <span style="padding-right: 10px; font-weight: 700; color: #2eb1d3;">원</span>
			    		 </td>
			    	</tr>
		    	</tfoot>
		    </table>
			</form>
			
		</div>
	</div>
 </div>

</body>
</html>