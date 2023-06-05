<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EMP 테이블 정보</title>
<style>
	table {
		border-collapse: collapse;
		width: 100%;
	}
	
	th, td {
		border: 1px solid #ddd;
		padding: 1px;
		text-align: left;
	}
	
	.delete {
		cursor: pointer;
	}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function() {
		// 회원정보들 가져오기 
		$('#getEmpListBtn').on('click', function() {
			
			$.ajax({ //jquery ajax
				type : "post", //post방식으로 가져오기 (get 요청시 get 기재 / default get)
				url : "/Jquery_Test/api/join", //서버에 요청할 경로(컨트롤러 매핑주소)
				success : function(result) { //요청 성공시 실행될 영역 (서버(컨트롤러)에서 보낸 데이터가 result에 담김)
					console.log("통신성공");
					console.log(JSON.stringify(result));
					
					let emplist = result;
					
					//테이블 비우기
					$("#emplistTable tbody").empty();
					
					//데이터 출력하기
					for(let empno in emplist){
						let emp = emplist[empno];
						
						let row = "<tr>";
						row += "<td class='deptno'>" + emp.deptno + "</td>";
						row += "<td class='empno'>" + emp.empno + "</td>";
						row += "<td class='ename'>" + emp.ename + "</td>";
						row += "<td class='sal'>" + emp.sal + "</td>";
						row += "<td class='hiredate'>" + emp.hiredate + "</td>";
						row += "<td class='delete'>X</td>";
						row += "</tr>";
						
						$("#emplistTable tbody").append(row);
					}
				},
				error : function() { //요청 실패시 실행될 영역
					console.log("통신에러");
				}
			});
		});

		// 회원정보 입력 
		$('#insertBtn').on('click', function() {
			//회원 데이터 담기
			let deptno = $("#deptno").val();
			let empno = $("#empno").val();
			let ename = $("#ename").val();
			let sal = $("#sal").val();
			let hiredate = $("#hiredate").val();
			
			$.ajax({ //jquery ajax
				type : "post", //post방식으로 가져오기 (get 요청시 get 기재 / default get)
				url : "/Jquery_Test/api/insert", //서버에 요청할 경로(컨트롤러 매핑주소)
				data : {
					deptno: deptno,
					empno: empno,
					ename: ename,
					sal: sal,
					hiredate: hiredate
				},
				success : function(result) { //요청 성공시 실행될 영역 (서버(컨트롤러)에서 보낸 데이터가 result에 담김)
					console.log("통신성공");
					
					$("#deptno").val("");
					$("#empno").val("");
					$("#ename").val("");
					$("#sal").val("");
					$("#hiredate").val("");
					
					//데이터 출력하기
					for(let empno in emplist){
						let emp = emplist[empno];
						
						let row = "<tr>";
						row += "<td class='deptno'>" + deptno + "</td>";
						row += "<td class='empno'>" + empno + "</td>";
						row += "<td class='ename'>" + ename + "</td>";
						row += "<td class='sal'>" + sal + "</td>";
						row += "<td class='hiredate'>" + hiredate + "</td>";
						row += "<td class='delete'>X</td>";
						row += "</tr>";
						
						$("#emplistTable tbody").append(row);
					}
				},
				error : function() { //요청 실패시 실행될 영역
					console.log("통신에러");
				}
			});
		});

		// 선택 회원 삭제 
		$('#emplistTable').on('click', '.delete', function() {
			//X와 같은 행의 empno 가져오기
			let empno = $(this).closest("tr").find(".empno").text();
			console.log(empno);
			
			$.ajax({
				type : "post",
				url : "/Jquery_Test/api/delete",
				data : {
					empno: empno,
				},
				success : function(result){
					console.log("통신성공");
					
					//지우기
					$(this).closest("tr").empty();
				},
				error : function() {
					console.log("통신에러");
				}
			})
		});

	});
</script>
</head>
<body>
	<h1>EMP 테이블 정보</h1>
	<div>
		<hr>
		<table id="emplistTable">
			<thead>
				<tr>
					<th>부서 번호</th>
					<th>사원 번호</th>
					<th>이름</th>
					<th>연봉</th>
					<th>입사일</th>
					<th>사원 데이터 삭제</th>
				</tr>
			</thead>
			<!-- jstl 문으로 반복문 돌려서 select 결과 가져와서 td 태그 데이터 담아야함 -->
			<tbody>
				<!-- 동적으로 데이터 생성 -->
			</tbody>
		</table>
		<button type="button" id="getEmpListBtn">사원정보 가져오기</button>
		<hr>
		<div>
			부서번호 :<input type="text" id="deptno"><br>
			사원번호 :<input type="text" id="empno"><br>
			이름 :<input type="text" id="ename"><br> 
			연봉 :<input type="text" id="sal"><br>
			입사일 : <input type="date" id="hiredate"><br>
		</div>
		<button type="button" id="insertBtn">사원 정보 insert</button>

	</div>
</body>
</html>