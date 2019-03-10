<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>修改投票</title>
		<script src="${APP_PATH }/static/js/jquery-3.3.1.js"></script>
		<script src="${APP_PATH }/static/js/jquery.datetimepicker.js"></script>
		<script src="${APP_PATH }/static/js/jquery.js"></script>
		<script src="${APP_PATH }/static/js/jquery.datetimepicker.full.min.js"></script>
		<script src="${APP_PATH }/static/js/jquery.datetimepicker.full.js"></script>
		<script src="${APP_PATH }/static/js/jquery.datetimepicker.min.js"></script>
		<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
		<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="${APP_PATH }/static/css/jquery.datetimepicker.css">
		
		<script>
      //图片上传预览    IE是用了滤镜。
        function previewImage(file,preview)
        {
          var MAXWIDTH  = 51; 
          var MAXHEIGHT = 34;
//           var div = document.getElementById('preview');
			var div = preview;
          if (file.files && file.files[0])
          {
        	  $(div).prev().attr("link_address",file.files[0].name);
        	  console.log(file.files[0].name);
        	  $(div).empty();
              $(div).append('<img class="imghead" border="0" src="${APP_PATH }/static/images/after.png" width="51" height="34" onclick="$(this).parent().next().click()">');
              var img = $(preview).children().eq(0);
              img.onload = function(){
                var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
                img.width  =  rect.width;
                img.height =  rect.height;
//                 img.style.marginLeft = rect.left+'px';
                img.style.marginTop = rect.top+'px';
              }
              var reader = new FileReader();
              reader.onload = function(evt){img.src = evt.target.result;}
              reader.readAsDataURL(file.files[0]);
          }
          else //兼容IE
          {
            var sFilter='filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src="';
            file.select();
            var src = document.selection.createRange().text;
            $(div).empty();
            $(div).append('<img class=imghead border="0" src="${APP_PATH }/static/images/after.png" width="51" height="34" onclick="$(this).parent().next().click()">');
            var img = $(preview).children().eq(0);
            img.filters.item('DXImageTransform.Microsoft.AlphaImageLoader').src = src;
            var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
            status =('rect:'+rect.top+','+rect.left+','+rect.width+','+rect.height);
            $(div).append("<div class=divhead style='width:"+rect.width+"px;height:"+rect.height+"px;margin-top:"+rect.top+"px;"+sFilter+src+"\"'></div>");
          }
        }
        function clacImgZoomParam( maxWidth, maxHeight, width, height ){
            var param = {top:0, left:0, width:width, height:height};
            if( width>maxWidth || height>maxHeight ){
                rateWidth = width / maxWidth;
                rateHeight = height / maxHeight;
                
                if( rateWidth > rateHeight ){
                    param.width =  maxWidth;
                    param.height = Math.round(height / rateWidth);
                }else{
                    param.width = Math.round(width / rateHeight);
                    param.height = maxHeight;
                }
            }
            param.left = Math.round((maxWidth - param.width) / 2);
            param.top = Math.round((maxHeight - param.height) / 2);
            return param;
        }
    </script>
    
		<style type="text/css">
			.row {
				margin-right: -15px;
				margin-left: -15px;
				border: 1px solid silver;
				border-radius: 4px;
				padding: 25px 15px 15px;
				background-color: #FCFCFC;
				padding-top: 15px;
			}

			.btn-primary {
				color: #fff;
				background-color: #2795DC;
				border-color: #2e6da4;
			}
		
			.btn-primary:hover {
				color: #fff;
				background-color: #104E8B;
				border-color: #204d74;
			}
			
			.glyphicon {
				line-height: 1.42857143;
			}
		</style>
	</head>

	<body>
		<div class="container">
			<div class="row" id="create_page">
				<div class="col-md-12">
					<form class="form-horizontal" action="${APP_PATH }/saveVote" method="post" enctype="multipart/form-data">
						<div class="form-group">
							<label class="col-sm-2 control-label">请输入标题</label>
							<div class="col-sm-10">
								<input name="name" type="text" class="form-control" placeholder="先有鸡还是先有蛋？" value="${vote.name }">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">请描述标题</label>
							<div class="col-sm-10">
								<textarea name="description" class="form-control" rows="3" >${vote.description }</textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">投票候选项</label>
							<div class="col-sm-10" id="optionArea">
								<c:forEach items="${vote.options }" var="item"> 
									
									<div class="col-sm-12 one_option" style="margin: 0;padding: 0;">
										<input type="text" class="form-control" style="display: inline;width: 80%" value="${item.content }" option_id="${item.id }">
										
										<!-- 文件上传插件-->
										<div class="preview" style="display: inline;">
					                        <img class="imghead" border="0" src="${APP_PATH }/static/images/before.png" width="51" height="34" onclick="$(this).parent().next().click();">
					                    </div>         
					                    <input type="file" onchange="previewImage(this,$(this).prev())" name="img" style="display: none;" class="previewImg">
					                    <!-- 文件上传插件-->
					                    
										<button type="button" class="btn btn-danger btn_del" style="display: inline;width: 9%"><span class="glyphicon glyphicon-remove-circle"></span></button><br>
									</div>
									
								</c:forEach>
							</div>
							<input type="button" id="add_option_btn" class="btn btn-success" value="添加选项" style="margin-left: 140px;margin-top:10px" />
						</div>
						<hr />
						<div class="form-group">
							<label class="col-sm-2 control-label">单选  | 多选</label>
							<div class="col-sm-10">
								<div class="radio" style="display: inline;"><label><input type="radio" value="radio" name="type" id="radio_type"/>单选</label></div>
								<div class="radio" style="display: inline;margin-left: 10px;"><label><input type="radio" value="checkbox" name="type" id="checkbox_type"/>多选</label></div>
								<!-- <input type="radio" value="button" name="type" />一键投票 -->
							</div>
						</div>
						<hr />
						<div class="form-group">
							<label class="col-sm-2 control-label">投票截止时间</label>
							<div class="col-sm-10">
								<input name="endtime" type="text" class="form-control" id="datetimepicker" value="${endtime }"/>
							</div>
						</div>
						<div class="form-group" style="border: none;padding-bottom: 0px;">
							<div style="margin-left: 87%;">
								<input type="hidden" name="id" value="${vote.id }">
								<button id="create_btn" class="btn btn-primary" type="submit">保存修改</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			$('#datetimepicker').datetimepicker();
			$('#datetimepicker').datetimepicker({
				lang: 'ch', //设置中文
				format:"Y-m-d H:i:s" //格式化日期
			});
			
			//检查投票类型，给单选多选设值
			$(checkVoteType());
			function checkVoteType(){
				var type = '${vote.options[0].type}';
				if(type == "radio"){
					$("#radio_type").prop("checked","checked");
				}else{
					$("#checkbox_type").prop("checked","checked");
				}
			}
			
			$("body").on("click", "#add_option_btn", function() {
				var div = $("<div></div>").addClass("col-sm-12 one_option").attr("style","margin: 0;padding: 0;");
				var option = $("<input>").addClass("form-control").attr("type", "text").attr("style", "display: inline;width: 80%").attr("option_id"," ");
				var upload = $('<div class="preview" style="display: inline;margin-left: 4px;"><img class="imghead" border="0" src="${APP_PATH }/static/images/before.png" width="51" height="34" onclick="$(this).parent().next().click();"></div><input type="file" onchange="previewImage(this,$(this).prev())" name="img" style="display: none;" class="previewImg">');
				var del_btn = $("<button></button>").addClass("btn btn-danger btn_del").attr("type", "button").attr("style", "display: inline;width: 9%; margin-left:4px").append('<span class="glyphicon glyphicon-remove-circle"></span>');
				div.append(option).append(upload).append(del_btn);
				div.appendTo("#optionArea");
			});
			
			$("#create_btn").click(function() {
				var text = $("#optionArea input[type=text]");
				var value = [];

				$.each(text, function(index, item) {
					var option_id = $(item).attr("option_id")+"-";
					value.push(option_id+$(item).val()+"-"+$(item).attr("link_address"));
				});
				
				console.log(value);
				
				$.ajax({
					type: "POST",
					url: "${APP_PATH }/saveOption",
					data: {
						str_options: value,
						type: $("input[name='type']").val(),
						theme_id: '${vote.id}'
					},
					traditional: true,
					success:function(result){
						console.log(result);
					}
				});
				return true;
			});
			
			$("#optionArea").on("click", ".btn_del", function() {
				$(this).parent().remove();
			});
			
		</script>
	</body>

</html>