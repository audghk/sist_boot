<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		$("#createUserBtn").click(function(){//계정 생성
			var userId=$("#newUserId").val();
			var name=$("#name").val();
			$.ajax({
				url:"/api/users",
				type: "POST",//@PostMapping
				data: {userId : userId, name : name},
				dataType:"JSON",
				error:function(xhr){
					alert(xhr.status);
				},
				success: function(jsonObj){
					$("#output").html(jsonObj.msg);
				}
			});//ajax
		});//click	
		$("#getUserBtn").click(function(){//계정조회
			var userId=$("#userId").val();
			$.ajax({
				url:`/api/users/${userId}`,
				type: "GET",//@GetMapping({userId})
				dataType:"JSON",
				error:function(xhr){
					alert(xhr.status);
				},
				success: function(jsonObj){
					output="검색된 결과 없음";
					if(jsonObj.flag){
						output=`${userId}님의 검색 결과 ${jsonObj.name}`;
					}
					$("#output").html(output);
				}
			});//ajax
		});//click	
		$("#getAllUserBtn").click(function(){//계정조회
			var userId="all";
			$.ajax({
				url:`/api/users/${userId}`,
				type: "GET",//@GetMapping({userId})
				dataType:"JSON",
				error:function(xhr){
					alert(xhr.status);
				},
				success: function(jsonObj){
					output="<table><tr><th style='width:100px'>아이디</th><th style='width:300px'>이름</th></tr>";
					if(jsonObj.flag){
						$.each(jsonObj.data,function(i,jsonTemp){
						output+=`<tr><td>${jsonTemp.userId}</td><td>${jsonTemp.name}</td></tr>`;
						});//end each
					}//end if
					if(!jsonObj.flag){
						output+=`<tr><td colspan="2">회원 정보가 존재하지 않습니다.</td></tr>`;
					}//end if
					output+="</table>";
					$("#output").html(output);
				}//success
			});//ajax
		});//click	
		$("#updateUserBtn").click(function(){//계정조회
			var userId=$("#updateUserId").val();
			var name=$("#newName").val();
			$.ajax({
				url:`/api/users/${userId}`,
				type: "PUT",//@PutMapping({userId})
				data: {name:name},
				dataType:"JSON",
				error:function(xhr){
					alert(xhr.status);
				},
				success: function(jsonObj){
					output="검색된 결과 없음";
					if(jsonObj.flag){
						output=`${userId}님의 이름을 ${name}으로 변경하였습니다.`;
					}
					$("#output").html(output);
				}
			});//ajax
		});//click
		$("#deleteUserBtn").click(function(){//계정조회
			var userId=$("#deleteUserId").val();
			$.ajax({
				url:`/api/users/${userId}`,
				type: "DELETE",//@DeleteMapping({userId})
				dataType:"JSON",
				error:function(xhr){
					alert(xhr.status);
				},
				success: function(jsonObj){
					output="검색된 결과 없음";
					if(jsonObj.flag){
						output=`${userId}님의 정보를 삭제하였습니다.`;
					}
					$("#output").html(output);
				}
			});//ajax
		});//click
		
	});//ready
</script>
</head>
<body>
<h1>Spring Boot RESTful CRUD예</h1>
<h2>계정생성</h2>
아이디 : <input type="text" id="newUserId" placeholder="아이디"/><br/>
이름 : <input type="text" id="name" placeholder="이름"/><br/>
<input type="button" id="createUserBtn" value="생성"/><br/>
<h2>계정조회</h2>
아이디 : <input type="text" id="userId" placeholder="아이디"/><br/>
<input type="button" id="getUserBtn" value="조회"/><br/>
<h2>전체조회</h2>
<input type="button" id="getAllUserBtn" value="전체조회"/><br/>
<h2>계정변경</h2>
아이디 : <input type="text" id="updateUserId" placeholder="아이디"/><br/>
이름 : <input type="text" id="newName" placeholder="이름"/><br/>
<input type="button" id="updateUserBtn" value="계정정보 변경"/><br/>
<h2>계정 삭제</h2>
아이디 : <input type="text" id="deleteUserId" placeholder="아이디"/><br/>
<input type="button" id="deleteUserBtn" value="삭제"/>

<div>
<h2>결과창</h2>
<div id="output"></div>
</div>
</body>
</html>