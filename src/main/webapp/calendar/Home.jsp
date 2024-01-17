<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Calendar</title>
<meta charset="utf-8">
<!-- Fonts  -->
<!-- Fonts -->
<link
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Fira+Mono&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="/Calendar/css/style.css">
<link rel="stylesheet" href="/Calendar/css/dec.css">
<link rel="stylesheet" href="/Calendar/css/record.css">
<link rel="stylesheet" href="/Calendar/css/evo-calendar.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/Calendar/css/style.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
<!-- tobar style -->
<style>
@font-face {
	font-family: BungeeInline;
	src: url(./fontfamily/BungeeInline.ttf)
}
</style>
</head>
<body>
	<div class="topbar">
		<!-- <div style="padding-top:0px;padding-left:0px;height:100px"> -->
		<div class="topbar_title">Accounting Diary</div>
	</div>
	<div class="leftbar">
		<button class="icon-home2 icon_home" title="主頁"
			onclick="window.location.href='/Calendar/calendar/Home.jsp'"></button>
		<br>
		<button class="icon-coin-dollar icon_dollar" title="記帳"
			onclick="window.location.href='/Calendar/calendar/Record.jsp'"></button>
		<br>
		<button class="icon-stats-dots icon_form" title="圖表"
			onclick="window.location.href='/Calendar/calendar/Chart.jsp'"></button>
		<br>
		<button class="icon-cog icon_setting" title="設定"></button>
		<br>
		<button class="icon-exit icon_exit" title="登出"
			onclick="window.location.href='/Calendar/calendar/login.jsp'"></button>
	</div>
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
</body>

<!-- jQuery -->
<script src="./javascript/jquery-3.6.0.js"></script>
<script src="./javascript/evo-calendar.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<!-- 主畫面頁面 -->
<script>
	$(function() {
		$('#calendar').evoCalendar();
		//$('#calendar').evoCalendar('addCalendarEvent', {
		//     id: 'kNybja6',
		//     name: 'Mom\'s Birthday',
		//     description: 'Lorem ipsum dolor sit..',
		//     date: '2024-1-1',
		//     type: 'birthday'
		//});
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
</script>

<!-- popover 暫時沒有用 -->
<script>
	var popoverTriggerList = [].slice.call(document
			.querySelectorAll('[data-bs-toggle="popover"]'))
	var popoverList = popoverTriggerList.map(function(popoverTriggerEl) {
		return new bootstrap.Popover(popoverTriggerEl)
	})
</script>

<script>
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
</html>





