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
		<title>在线投票网</title>

		<script src="${APP_PATH }/static/js/jquery-3.3.1.js"></script>
		<script src="${APP_PATH }/static/js/jquery-3.3.1.min.js"></script>
		<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
		<link href="${APP_PATH }/static/css/my.css" rel="stylesheet">
		<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
		<link rel="shortcut icon" type="image/x-icon" href="${APP_PATH }/static/images/favicon.ico">
		<style type="text/css">
			.list-group-item {
				background-color: #f5f5f5;
			}
			
			a.list-group-item:focus,
			a.list-group-item:hover,
			button.list-group-item:focus,
			button.list-group-item:hover {
				color: #555;
				text-decoration: none;
				background-color: #dff0d8;
			}
			
			.container {}
		</style>
	</head>

	<body>
		<div class="container">
			<!--导航条-->
			<div class="row">
				<div class="col-md-12" align="center">
					<nav class="navbar navbar-inverse">
						<div class="container-fluid">
							<!-- Brand and toggle get grouped for better mobile display -->
							<div class="navbar-header">
								<a class="navbar-brand" href="VoteIndex.jsp" style="padding: 0;margin-left: 15px"><img src="${APP_PATH }/static/images/logo.png" height="50px"></a>
							</div>

							<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
								<ul class="nav navbar-nav">
									<li>
										<a href="VoteIndex.jsp" style="font-size: 24px;color: white;margin-left: 20px">在线投票网</a>
									</li>
								</ul>
								<form class="navbar-form navbar-left" role="search" style="margin-left: 174px">
									<div class="form-group">
										<input type="text" class="form-control" name="keyWord" placeholder="Search">
									</div>
									<button type="button" class="btn btn-default" id="seach_btn">Submit</button>
								</form>
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

			<!--所有投票-->
			<div class="row">
				<div class="col-md-12">
					<div class="panel panel-default">
						<!-- Default panel contents -->
						<div class="panel-heading" style="font-size: 30px">人气投票</div>
						<div class="panel-body" align="center">
							<p><img src="${APP_PATH }/static/images/logo.png" width="180px"></p>
						</div>

						<!-- List group -->
						<div class="list-group" id="voteArea">

						</div>
					</div>
				</div>
			</div>
		</div>
		<script>
			$(function() {
				to_page(1);
			});

			function to_page(num) {
				$.ajax({
					url: "${APP_PATH }/getAllVotes",
					data: {
						pageNum : num,
						keyWord : $("input[name=keyWord]").val()
					},
					type: "get",
					success: function(result) {
						$("#voteArea").empty();
						build_vote_list(result);
					}
				});
			}

			function build_vote_list(result) {
				var vote_list = result.map.pageInfo.list;
				$.each(vote_list, function(index, item) {
					var a = $("<a></a>").attr("href", "${APP_PATH }/showDoVoteView?id=" + item.id).addClass("list-group-item");
					var span1 = $("<span></span>").addClass("badge");
					var span2 = $("<span></span>").addClass("glyphicon glyphicon-eye-open").attr("aria-hidden", "true");
					span1.append(span2).append(" " + item.totalVote);
					a.append(span1).append(item.name);
					$("#voteArea").append(a);
				});

				var nav = $("<nav></nav>").attr("aria-label", "...");
				var ul = $("<ul></ul>").addClass("pager");
				var pre_a = $("<a></a>").append("<b>Previous</b>").attr("href", "javascript:void(0)");
				var pre_li = $("<li></li>");
				var next_a = $("<a></a>").append("<b>Next</b>").attr("href", "javascript:void(0)");
				var next_li = $("<li></li>");

				if(result.map.pageInfo.hasPreviousPage == false) {
					pre_li.addClass("disabled");
				} else {
					pre_a.css("color", "#2795DC");
					pre_li.click(function() {
						to_page(result.map.pageInfo.prePage);
					});
				}

				if(result.map.pageInfo.hasNextPage == false) {
					next_li.addClass("disabled");
				} else {
					next_a.css("color", "#2795DC");
					next_li.click(function() {
						to_page(result.map.pageInfo.nextPage);
					});
				}
				
				pre_li.append(pre_a);
				next_li.append(next_a);
				ul.append(pre_li).append("<span>&nbsp;&nbsp;&nbsp;&nbsp;</span>").append(next_li);
				nav.append(ul);
				$("#voteArea").append(nav);
			}
			
			$("#seach_btn").click(function(){
				to_page(1);
			});
		</script>
	</body>

</html>