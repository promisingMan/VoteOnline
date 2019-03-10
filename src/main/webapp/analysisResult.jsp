<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>投票分析</title>
<script src="${APP_PATH }/static/js/jquery-3.3.1.js"></script>
</head>
<body style="height: 100%; margin: 0">
       <div id="container" style="height: 500px;"></div>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/echarts.min.js"></script>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts-gl/echarts-gl.min.js"></script>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts-stat/ecStat.min.js"></script>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/dataTool.min.js"></script>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/china.js"></script>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/world.js"></script>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/simplex.js"></script>
       <script type="text/javascript">
       var dom = document.getElementById("container");
       var myChart = echarts.init(dom);
       var app = {};
       app.title = '投票结果-条形图';
       
       var vote_id = '${param.vote_id}';
       var yAxis_data = [];
       var series_data = [];
       
       $.ajax({
			type: "GET",
			url: "${APP_PATH }/voteAnalysis",
			data: {
				vote_id : vote_id
			},
			success: function(result) {
				console.log(result);
				var options = result.map.vote.options;
				$.each(options,function(index,item){
					yAxis_data.push(item.content);
					series_data.push(item.votedTimes);
				});
				myChart.setOption({
				           title: {
				               text: result.map.vote.name,
				               left:'6%',
				               textStyle:{
				                   //字体粗细 'normal','bold','bolder','lighter',100 | 200 | 300 | 400...
				                   fontWeight:'bolder',
				                   //字体系列
				                   fontFamily:'sans-serif',
				                   //字体大小
				   				   fontSize:25
				               }
				           },
				           tooltip: {
				               trigger: 'axis',
				               axisPointer: {
				                   type: 'shadow'
				               }
				           },
				           legend: {
				               data: ['票数'],
				               textStyle: {
				                   fontSize: 16,
				               }
				           },
				           grid: {
				               left: '3%',
				               right: '4%',
				               bottom: '3%',
				               containLabel: true
				           },
				           xAxis: {
				               type: 'value',
				               boundaryGap: [0, 0.01]
				           },
				           yAxis: {
				               type: 'category',
				               data: yAxis_data
				           },
				           series: [
				               {
				                   name: '票数',
				                   type: 'bar',
				                   data: series_data
				               }
				           ]
				       });
			}
	   });
       console.log(yAxis_data);
       console.log(series_data);
       </script>
</body>
</html>