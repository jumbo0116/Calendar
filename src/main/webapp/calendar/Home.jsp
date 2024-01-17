<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ include file="/calendar/fragements/header.jspf" %>

<style>
@font-face {
	font-family: BungeeInline;
	src: url(./fontfamily/BungeeInline.ttf)
}
</style>

<div class="outer">
	<div class="board">
		<div class="topic">
			<div class="dot dot_101"></div>
			<div class="dot_word">飲食</div>
			<div class="dot dot_102"></div>
			<div class="dot_word">交通</div>
			<div class="dot dot_103"></div>
			<div class="dot_word">娛樂</div>
			<div class="dot dot_104"></div>
			<div class="dot_word">日常用品</div>
			<div class="dot dot_105"></div>
			<div class="dot_word">醫療保健</div>
			<div class="dot dot_106"></div>
			<div class="dot_word">服飾</div>
			<div class="dot dot_107"></div>
			<div class="dot_word">稅金</div>
			<div class="dot dot_108"></div>
			<div class="dot_word">其他</div>
		</div>
		<div id="calendar" class="calendar"></div>
	</div>
</div>

<script>
	<!-- 主畫面頁面 -->
	$(function() {
		$('#calendar').evoCalendar();
		$.ajax({
			type : 'POST',
			url : '/Calendar/Display',			
			async : true,
			dataType : 'json',
			success : function(data) {
				console.log(data);
				if (data != null) {
					$.each(data,function(index,item){
						$('#calendar').evoCalendar('addCalendarEvent', item);
					});
				}
			},
			error : function(e) {
				debugger;
				alert("日期錯誤");
			}
		});
	});

	function getEventList() {
		$.ajax({
			type : 'POST',
			url : '/Calendar/controller/DisplayServlet',			
			async : true,
			dataType : 'json',
			success : function(d) {
				if (d != null) {
					$("#calendar").evoCalendar('addCalendarEvent', d);
				}
			},
			error : function(e) {
				debugger;
				alert("日期錯誤");
			}
		});
	}
</script>




