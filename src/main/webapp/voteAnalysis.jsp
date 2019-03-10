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
		<title>投票分析</title>

		<script src="${APP_PATH }/static/js/jquery-3.3.1.js"></script>
		<script src="${APP_PATH }/static/js/jquery-3.3.1.min.js"></script>
		<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
		<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
		
		<style type="text/css">
			#table_area {
			    border: 1px solid silver;
			    border-radius: 4px;
			    padding: 25px 15px 15px;
			    background-color: #FCFCFC;
			}
			
			.table {
				text-align: center;
			}
			
			.table thead tr th {
				text-align: center;
			}
			
			.table tbody tr td {
				padding: 10px;
			}
			
			.table-bordered td, .table-bordered th {
				border: 1.5px solid #CCCCCC !important;
			}
			
			.btn {
				display: inline-block;
				padding: 6px 12px;
				margin-top: 2px;
				font-size: 14px;
				font-weight: 400;
				line-height: 1.42857143;
				text-align: center;
				white-space: nowrap;
				vertical-align: middle;
				-ms-touch-action: manipulation;
				touch-action: manipulation;
				cursor: pointer;
				-webkit-user-select: none;
				-moz-user-select: none;
				-ms-user-select: none;
				user-select: none;
				background-image: none;
				border: 1px solid transparent;
				border-radius: 4px
			}
		</style>
	</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-12" align="center">
				<div id="table_area">
					<table class="table table-hover table-bordered">
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
						var voteAnalysis_td = $("<button type='button' class='btn btn-primary btn_analysis'></button>").append("数据分析").attr("vote_id", item.id);
						var btn_td = $("<td></td>").css("padding","0");
						btn_td.append(voteAnalysis_td);
						var tr = $("<tr></tr>").append(id_td).append(name_td).append(description_td).append(btn_td);
						$("#table_area tbody").append(tr);
					});
				}
			});
			$(document).on("click",".btn_analysis",function(){
				var vote_id = $(this).attr("vote_id");
				window.location.href="${APP_PATH }/analysisResult.jsp?vote_id="+vote_id;
			});
			
		</script>
</body>
</html>