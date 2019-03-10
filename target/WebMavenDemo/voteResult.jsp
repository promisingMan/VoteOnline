<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>${vote.name }</title>

		<script src="${APP_PATH }/static/js/jquery-3.3.1.js"></script>
		<script src="${APP_PATH }/static/js/jquery-3.3.1.min.js"></script>
		<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
		<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
		<link rel="shortcut icon" type="image/x-icon" href="${APP_PATH }/static/images/favicon.ico">
		<style type="text/css">
		.progress-bar-info {
			background-color: #3762BC
		}
		</style>
	</head>

	<body>
		<div class="container">
			<!-- 导航条-->
			<div class="row">
				<div class="col-md-12" align="center">
					<nav class="navbar navbar-inverse">
						<div class="container-fluid">
							<!-- Brand and toggle get grouped for better mobile display -->
							<div class="navbar-header">
								<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
									<span class="sr-only">Toggle navigation</span> 
									<span class="icon-bar"></span> 
									<span class="icon-bar"></span> 
									<span class="icon-bar"></span>
								</button>
								<a class="navbar-brand" href="VoteIndex.jsp" style="padding: 0;margin-left: 15px"><img src="${APP_PATH }/static/images/logo.png" height="50px"></a>
							</div>

							<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
								<ul class="nav navbar-nav">
									<li>
										<a href="VoteIndex.jsp" style="font-size: 24px;color: white;margin-left: 20px">在线投票网</a>
									</li>
								</ul>
								<ul class="nav navbar-nav navbar-right">
									<li>
										<a href="#" id="user"><span class="glyphicon glyphicon-user" aria-hidden="true"></span></a>
										<script type="text/javascript">
											var isLogined = '${username}';
											if(isLogined != '') {
												$("#user").append(' ' + isLogined + "|管理").attr("href", "index.jsp");
											} else {
												$("#user").append(" 登录|注册").attr("href", "loginAndRegister.jsp");
											}
										</script>
									</li>
									<li>
										<a href="${APP_PATH }/exit"><span class="glyphicon glyphicon-remove-sign" aria-hidden="true"></span> 退出</a>
									</li>
								</ul>
							</div>
						</div>
					</nav>
				</div>
			</div>

			<!-- 投票区域 -->
			<div class="row">
				<div class="col-md-12">
					<div class="panel panel-success">
						<!-- Default panel contents -->
						<div class="panel-heading" style="font-size: 30px">${vote.name}</div>
						<div class="panel-body" style="font-size: 15px;border-bottom: 1px solid silver;color: silver;">
							<span class="glyphicon glyphicon-time"></span> ${endtime }&nbsp;&nbsp;
							<span class="glyphicon glyphicon-eye-open"></span> ${vote.totalVote }&nbsp;&nbsp;
							<span class="glyphicon glyphicon-user"></span> ${vote_username}
						</div>
						<div class="panel-body" style="font-size: 20px;border-bottom: 1px solid silver;">
							${vote.description }
						</div>
						<div class="panel-body" style="font-size: 20px" id="optionArea">
							<c:forEach items="${vote.options }" var="item">
								${item.content } <span>(<fmt:formatNumber type="number" value="${item.votedTimes/vote.totalVote*100 }" pattern="0.00" maxFractionDigits="2"/>%, ${item.votedTimes}票)</span><br /><br />
								<div class="progress">
									<div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="${item.votedTimes/vote.totalVote*100 }" aria-valuemin="0" aria-valuemax="100" style="width: ${item.votedTimes/vote.totalVote*100 }%;">
										<fmt:formatNumber type="number" value="${item.votedTimes/vote.totalVote*100 }" pattern="0.00" maxFractionDigits="2" />%
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>

		</div>
	</body>

</html>