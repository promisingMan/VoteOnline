<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>修改密码</title>

		<script src="${APP_PATH }/static/js/jquery-3.3.1.js"></script>
		<script src="${APP_PATH }/static/js/jquery-3.3.1.min.js"></script>
		<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
		<link href="${APP_PATH }/static/css/my.css" rel="stylesheet">
		<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
		
		<style type="text/css">
			.btn-default {
				color: #333;
				background-color: #eee;
				border-color: #ccc;
				margin-top: 15px
			}
			.btn-default.focus, .btn-default:focus {
				color: #333;
				background-color: #BBBBBB;
				border-color: #8c8c8c
			}
			
			.btn-default:hover {
				color: #333;
				background-color: #BBBBBB;
				border-color: #adadad
			}
		</style>
		
	</head>

	<body>
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="panel panel-default">
						<!-- Default panel contents -->
						<div class="panel-heading" style="font-size: 30px">修改密码</div>
						<div class="panel-body" align="center">
							<div class="input-group">
								<span class="input-group-addon" id="basic-addon1">&nbsp;&nbsp;&nbsp;&nbsp;原密码&nbsp;&nbsp;&nbsp;</span>
								<input type="password" class="form-control" id="oldPwd" />
							</div>
							<br />
							<div class="input-group">
								<span class="input-group-addon" id="basic-addon2">&nbsp;&nbsp;&nbsp;&nbsp;新密码&nbsp;&nbsp;&nbsp;</span>
								<input type="password" class="form-control" />
							</div>
							<br />
							<div class="input-group">
								<span class="input-group-addon" id="basic-addon3">重复新密码</span>
								<input type="password" class="form-control" id="newPwd" />
							</div>
							<button type="button" class="btn btn-default">修改密码</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script>
			$("button").click(function(){
				$.ajax({
					type:"post",
					url:"${APP_PATH }/updatePassword",
					data:{
						id:'${user_id}',
						oldPwd:$("#oldPwd").val(),
						newPwd:$("#newPwd").val()
					},
					success:function(result){
						if (result = 'success'){
							$("input").val("");
							alert("修改成功");
						} else {
							alert("原密码错误");
						}
					}
				});
			});
		</script>
	</body>

</html>