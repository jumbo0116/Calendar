<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<%
String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
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
<link rel="stylesheet" href="/Calendar/css/evo-calendar.css">
<link rel="stylesheet" href="/Calendar/css/chart.css">
<link rel="stylesheet" href="/Calendar/css/charts.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css	">
<link rel="stylesheet" href="/Calendar/css/style.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
<!-- tobar style -->
<style>
@font-face {
	font-family: BungeeInline;
	src: url(/Calendar/calendar/fontfamily/BungeeInline.ttf)
}
</style>
<meta charset="utf-8">
<title>Insert title here</title>
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
		<div class="chart">
			<div class="chart_topbar">
				<div class="chart_topbar_left">
					<button class="icon-loop2 icon_switch"></button>
				</div>
				<div class="chart_topbar_right" id="chart_topbar_right">
					<div class="date date_left">
						From:&nbsp&nbsp<input type="text" id="datepicker"
							name="datepicker" autocomplete="off">
					</div>
					<div class="date date_right">
						To:&nbsp&nbsp<input type="text" id="datepicker2"
							name="datepicker2" autocomplete="off">
					</div>
				</div>
				<div class="chart_topbar_right2" id="chart_topbar_right2">
					<button class="icon-circle-up icon_up" onclick="increment()"></button>
					<div class="year" id="number" onclick="dateSet(2024, 0)">2024</div>
					<button class="icon-circle-down icon_down" onclick="decrement()"></button>
					<button class="month" onclick=" highlight(this)">1</button>
					<button class="month" onclick=" highlight(this)">2</button>
					<button class="month" onclick="dateSet(3); highlight(this)">3</button>
					<button class="month" onclick="dateSet(4); highlight(this)">4</button>
					<button class="month" onclick="dateSet(5); highlight(this)">5</button>
					<button class="month" onclick="dateSet(6); highlight(this)">6</button>
					<button class="month" onclick="dateSet(7); highlight(this)">7</button>
					<button class="month" onclick="dateSet(8); highlight(this)">8</button>
					<button class="month" onclick="dateSet(9); highlight(this)">9</button>
					<button class="month" onclick="dateSet(10); highlight(this)">10</button>
					<button class="month" onclick="dateSet(11); highlight(this)">11</button>
					<button class="month" onclick="dateSet(12); highlight(this)">12</button>
				</div>
			</div>
			<div class="chart_bottombar">	
				<div class="bottombar_left">	
					<button class="icon-pie-chart icon_pie icon_highlight" onclick=" highlightbar(this)"></button>
					<div>
						<canvas id="myChart" class="pieChart"></canvas>
						<canvas id="myChart2" class="barChart"></canvas>
					</div>
					<button class="icon-stats-bars icon_bar icon_highlight" onclick=" highlightbar(this)"></button>
				</div>	
			</div>
		</div>
	</div>
</body>

<!-- jQuery -->
<script src="/Calendar/calendar/javascript/jquery-3.6.0.js"></script>
<script src="/Calendar/calendar/javascript/evo-calendar.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<!-- 日期選擇 -->
<script>
	$(function() {
		$("#datepicker").datepicker();
	});
	$(function() {
		$("#datepicker2").datepicker();
	});
</script>

<!-- 日期選擇&月份選擇切換 -->
<script>
	$(function() {
		$('.chart_topbar_right2').hide();
		$('.chart_topbar_right').show();

		$('.icon_switch').on('click', function() {
			if ($('.chart_topbar_right').is(':hidden')) {
				$('.chart_topbar_right2').hide();
				$('.chart_topbar_right').show();
			} else {
				$('.chart_topbar_right').hide();
				$('.chart_topbar_right2').show();
			}
		});
	});
</script>

<!-- 年份 -->
<script>
	// 初始數字
	let currentYear = 2024;

	// 更新顯示數字的函數
	function updateYear() {
		document.getElementById('number').innerText = currentYear;
	}

	// 加法函數
	function increment() {
		currentYear += 1;
		updateYear();
	}

	// 減法函數
	function decrement() {
		currentYear -= 1;
		updateYear();
	}

	// 監聽鍵盤事件
	document.addEventListener('keydown', function(event) {
		// 按下鍵盤上的 "ArrowUp"，執行加法
		if (event.key === 'ArrowUp') {
			increment();
		}
		// 按下鍵盤上的 "ArrowDown"，執行減法
		else if (event.key === 'ArrowDown') {
			decrement();
		}
	});
</script>

<!-- 月份點擊反白 -->
<script>
	function highlight(button) {
		  const buttons = document.querySelectorAll('.month');
		  buttons.forEach(btn => {
		    btn.classList.remove('highlighted');
		  });
	
		  // 将點擊的按钮添加高亮类
		  button.classList.add('highlighted');
		  console.log('Highlight function called with button:', button);
		}
</script>

<!-- icon點擊反白 -->
<script>
	function highlightbar(button) {
		  const buttons = document.querySelectorAll('.icon_highlight');
		  buttons.forEach(btn => {
		    btn.classList.remove('highlightedbar');
		  });
	
		  // 将點擊的按钮添加高亮类
		  button.classList.add('highlightedbar');
		  console.log('Highlight function called with button:', button);
		}
</script>

<script>
	function dateSet(month) {
		updateDate(currentYear, month);

		var dataToSend = {
			year : currentYear,
			month : month
		};

		$.ajax({
			type : "POST",
			url : "/Calendar/Chart",
			data : dataToSend,
			success : function(response) {
				console.log("Data sent successfully:", response);
			},
			error : function(error) {
				console.error("Error sending data:", error);
			}
		});
	}
</script>

<!-- 統計圖 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
	$(function() {
		$('.barChart').hide();
		$('.pieChart').show();

		$('.icon_pie').on('click', function() {			
				$('.barChart').hide();
				$('.pieChart').show();
		});
		$('.icon_bar').on('click', function() {			
			$('.pieChart').hide();
			$('.barChart').show();
		});
	});
</script>

<!-- 圓餅圖 -->
<script>
//調用 fetchData 函數，初始化圖表
fetchData();

function fetchData() {
 var targetYear = 2024; // 設定初始年份
 var targetMonth = 1; // 設定初始月份

 $.ajax({
     type: "POST",
     url: "/Calendar/Chart",
     data: { year: targetYear, month: targetMonth },
     success: function (data) {
         // 使用返回的 JSON 數據初始化圖表
         updateChart(data);
     },
     error: function (error) {
         console.error("Error fetching data:", error);
     }
 });
}
function updateChart(chartData) {
  const data = document.getElementById('myChart');
	  if (data) {
		    // 如果 canvas 元素已存在，先銷毀之前的圖表
		    Chart.getChart(data)?.destroy();
	  }
	  new Chart(data, {
	    type: 'doughnut',
	    data: {
	      labels: ['飲食', '交通', '娛樂','日常用品','醫療保健','服飾','稅金','其他'],
	      datasets: [{
	        label: '',
	        data: chartData,
	        backgroundColor: [
	        	'#00fb62',
	            '#ff7400',
	            '#f6f700',
	            '#00ffcd',
	            '#f50000',
	            '#ee00f5',
	            '#cdd5ed',
	            '#0039f9'
	          ],
	        borderWidth: 1
	      }]
	    },
	    options: {
	      scales: {
	        y: {        	
	          beginAtZero: true
	        }
	      }
	    }
	  });
}
	  
</script>

<!-- 長條圖 -->
<script>
// 調用 fetchData 函數，初始化圖表
fetchData();

function fetchData() {
    var targetYear = 2024; // 設定初始年份
    var targetMonth = 1; // 設定初始月份

    $.ajax({
        type: "POST",
        url: "/Calendar/Chart",
        data: { year: targetYear, month: targetMonth },
        success: function (data) {
            // 使用返回的 JSON 數據初始化圖表
            updateChart(data);
        },
        error: function (error) {
            console.error("Error fetching data:", error);
        }
    });
}

function updateChart(chartData) {
	
  const data2 = document.getElementById('myChart2');
  if (data2) {
	    // 如果 canvas 元素已存在，先銷毀之前的圖表
	    Chart.getChart(data2)?.destroy();
  }

	  new Chart(data2, {
	    type: 'bar',
	    data: {
	      labels: ['飲食', '交通', '娛樂','日常用品','醫療保健','服飾','稅金','其他'],
	      datasets: [{
	        label: '',
	        data: chartData,
	        backgroundColor: [
	            '#00fb62',
	            '#ff7400',
	            '#f6f700',
	            '#00ffcd',
	            '#f50000',
	            '#ee00f5',
	            '#cdd5ed',
	            '#0039f9'
	          ],
	        borderWidth: 1
	      }]
	    },
	    options: {
	      scales: {
	        y: {
	          beginAtZero: true
	        }
	      }
	    }
	  });
}

</script>
</html>