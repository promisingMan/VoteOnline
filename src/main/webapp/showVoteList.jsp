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
		<title>展示投票</title>

		<script src="${APP_PATH }/static/js/jquery-3.3.1.js"></script>
		<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>

		<style type="text/css">
			#table_area {
			    border: 1px solid silver;
			    border-radius: 4px;
			    padding: 30px 15px 15px;
			    background-color: #FCFCFC;
			}
			
			.table {
				text-align: center;
			}
			
			.table thead tr th {
				text-align: center;
			}
			
			.table-bordered td, .table-bordered th {
				border: 1.5px solid #CCCCCC !important;
			}
			
			button{
				margin-left: 3px;
			}
			.btn-info {
				color: #fff;
				background-color: #d2df08;
				border-color: #9cac16;
			}
			.btn-info:hover {
				color: #fff;
				background-color: #7c9710;
				border-color: #269abc;
			}
			
		</style>

	</head>

	<body>
	
	<div class="container">
			<div class="row">
				<div class="col-md-12" id="vote_list">
				<div id="table_area">
					<table class="table table-bordered table-hover">
						<thead>
							<tr>
								<th>#</th>
								<th>投票名</th>
								<th>投票描述</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
				</div>
			</div>
		</div>
		<script>
			$.ajax({
				type: "GET",
				url: "${APP_PATH }/showVoteList",
				data: {
					user_id : '${user_id}'
				},
				success: function(result) {
					console.log(result);
					var themes = result.map.themes;
					$.each(themes, function(index, item) {
						var id_td = $("<td></td>").append(item.id);
						var name_td = $("<td></td>").append(item.name);
						var description_td = $("<td></td>").append(item.description);
						var voteInfo_td = $("<button type='button' class='btn btn-primary btn_info'></button>").append("投票详情").attr("vote_id", item.id);
						var delVote_td = $("<button type='button' class='btn btn-danger btn_del'></button>").append("删除投票").attr("vote_id", item.id);
						var editVote_td = $("<button type='button' class='btn btn-info btn_edit'></button>").append("编辑投票").attr("vote_id", item.id);
						var btn_td = $("<td></td>").css("padding","0");
						btn_td.append(voteInfo_td).append(delVote_td).append(editVote_td);
						var tr = $("<tr></tr>").append(id_td).append(name_td).append(description_td).append(btn_td);
						$("#vote_list tbody").append(tr);
					});
				}
			});
			$(document).on("click",".btn_info",function(){
				var vote_id = $(this).attr("vote_id");
				window.location.href="${APP_PATH }/getVoteInfo?vote_id="+vote_id;
			});
			
			$(document).on("click",".btn_del",function(){
				var vote_id = $(this).attr("vote_id");
				var sure = window.confirm("确认删除？");
				if (sure){
					window.location.href="${APP_PATH }/deleteVote?vote_id="+vote_id;
				}
			});
			
			$(document).on("click",".btn_edit",function(){
				var vote_id = $(this).attr("vote_id");
				window.location.href="${APP_PATH }/editVote?vote_id="+vote_id;
			});
		</script>
	</body>

</html>