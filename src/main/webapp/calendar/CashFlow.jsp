<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<link rel="stylesheet" href="/Calendar/css/chart.css">
<link rel="stylesheet" href="/Calendar/css/CashFlow.css">

<%@ include file="/calendar/fragements/header.jspf"%>

<%@ page import="controller.MoneyServlet"%>

<%
String error = (String) request.getAttribute("error");
Integer totalIncome = (Integer) request.getAttribute("totalIncome");
Integer totalExpense = (Integer) request.getAttribute("totalExpense");
%>

<div class="outer">
	<div class="chart">
		<div class="chart_topbar">
			<div class="chart_topbar_right" id="chart_topbar_right">
				<div class="date date_left">
					From:&nbsp&nbsp<input type="text" id="datepicker" name="datepicker"
						autocomplete="off">
				</div>
				<div class="date date_right">
					To:&nbsp&nbsp<input type="text" id="datepicker2" name="datepicker2"
						autocomplete="off">
				</div>
			</div>
			<div class="chart_topbar_right2" id="chart_topbar_right2">
				<button class="icon-circle-up icon_up" onclick="increment()"></button>
				<div class="year" id="number" onclick="dateSet(2024, 0)">2024</div>
				<button class="icon-circle-down icon_down" onclick="decrement()"></button>
				<button class="month" onclick="dateSet(1); highlight(this)">1</button>
				<button class="month" onclick="dateSet(2); highlight(this)">2</button>
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
			<div class="top_outer">
				<div class="bottombar_left">
					<span class="icon-coin-dollar icon_cash"></span>
					<div class="word_cash">Cash</div>
				</div>
					<div class="cash_wrapper">
						<h1 class="cash_income word">income&nbsp:</h1>
						<h1 class="cash_income_show">XXX</h1>						
						<h1 class="cash_expense word">expense&nbsp:</h1>						
						<h1 class="cash_expense_show">XXX</h1>
					</div>
			</div>
			<div class="mid_outer">
				<div class="bottombar_mid">
					<span class="icon-library icon_bank"></span>
					<div class="word_Bank">Bank Account</div>
				</div>
					<div class="mid_wrapper">
						<div>
							<h1 class="mid_income word">income&nbsp:</h1>
							<h1 class="mid_income_show">XXX</h1>
						</div>
						<div>					
							<h1 class="mid_expense word">expense&nbsp:</h1>
							<h1 class="mid_expense_show">XXX</h1>
						</div>
					</div>
			</div>
			<div class="bottom_outer">
				<div class="bottombar_right">
					<span class="icon-credit-card icon_card"></span>
					<div class="word_card">Credit Card</div>
				</div>
					<div class="card_wrapper">
						<h1 class="card_income word">income&nbsp:</h1>
						<h1 class="card_income_show">XXX</h1>
						<h1 class="card_expense word">expense&nbsp:</h1>
						<h1 class="card_expense_show">XXX</h1>
					</div>
			</div>
		</div>
	</div>
</div>

<style>
@font-face {
	font-family: BungeeInline;
	src: url(/Calendar/calendar/fontfamily/BungeeInline.ttf)
}
</style>

<script>

	<!-- 日期選擇 -->
	$(function() {
		$("#datepicker").datepicker();
	});
	$(function() {
		$("#datepicker2").datepicker();
	});
	<!-- 日期選擇&月份選擇切換 -->
	$(function() {
		$('.chart_topbar_right').hide();
		$('.chart_topbar_right2').show();
	
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

	<!-- 年份 -->
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

	<!-- 月份點擊反白 -->

		function highlight(button) {
			  const buttons = document.querySelectorAll('.month');
			  buttons.forEach(btn => {
			    btn.classList.remove('highlighted');
			  });
		
			  // 将點擊的按钮添加高亮类
			  button.classList.add('highlighted');
			  console.log('Highlight function called with button:', button);
			}


	<!-- icon點擊反白 -->
	function highlightbar(button) {
		  const buttons = document.querySelectorAll('.icon_highlight');
		  buttons.forEach(btn => {
		    btn.classList.remove('highlightedbar');
		  });
	
		  // 将點擊的按钮添加高亮类
		  button.classList.add('highlightedbar');
		  console.log('Highlight function called with button:', button);
	}
	
	

	<!-- 月份選擇 -->
	var dataToSend; // 声明dataToSend变量
	
	function updateDate(year, month) {
	    console.log('Year:', year, 'Month:', month);
	}
	
	function dateSet(month) {
		updateDate(currentYear, month);
		fetchChart(currentYear,month);
		fetchMoney(currentYear,month);		
		
		// 移除 icon_bar 的反白狀態
	    const iconBar = document.querySelector('.icon_bar');
	    iconBar.classList.remove('highlightedbar');
		 // 增加 icon_pie 的反白狀態
	    const iconPie = document.querySelector('.icon_pie');
	    iconPie.classList.add('highlightedbar');
	}

	<!-- 統計圖表 -->
	$(document).ready(function () {
	    // 調用 fetchData 函數，初始化圖表
	    fetchData();
	});
	
	function fetchData() {
	    var targetYear = 2024; // 設定初始年份
	    var targetMonth = 1; // 設定初始月份
	    fetchChart(targetYear,targetMonth);
	    fetchMoney(targetYear,targetMonth);
	}
	
	function fetchChart(targetYear,targetMonth) {
	    $.ajax({
	        type: "POST",
	        url: "/Calendar/Chart",
	        data: { year: targetYear, month: targetMonth },
	        success: function (data) {
	        	console.log(data);
	        	// 使用返回的 JSON 數據初始化圖表
	            updateCharts(data);
	        },
	        error: function (error) {
	            console.error("Error fetching data:", error);
	        }
	    });
	}
	
	function fetchMoney(targetYear,targetMonth) {
		$.ajax({
			type : "POST",
			url : "/Calendar/Money",
			dataType: 'json',
			data : {
				year: targetYear,
				month: targetMonth
			},
			success : function(data) {
				console.log("Data sent successfully:", data);
				console.log("Data sent successfully:", data.totalIncome);
				console.log("Data sent successfully:", data.totalExpense);
				$('#totalIncome').text(data.totalIncome);
				$('#totalExpense').text(data.totalExpense);
			},
			error : function(error) {
				console.error("Error sending data:", error);
			}
		});
	}
	
	function updateCharts(chartData) {
		
		console.log(chartData);
		
		// 提取 datasets 配置
	    const datasetsConfig = {
	        labels: ['飲食', '交通', '娛樂', '日常用品', '醫療保健', '服飾', '稅金', '其他'],
	        datasets: [{
	            label: '',
	            data: chartData,
	            backgroundColor: [
	                '#30fd9c',
	                '#ff4a4a',
	                '#00f5e7',
	                '#fff400',
	                '#8e00ff',
	                '#ff7ddf',
	                '#ffffff',
	                '#f9c497'
	            ],
	            borderWidth: 1
	        }]
	    };
	
	    // 更新圓餅圖
	    const pieChartCanvas = document.getElementById('myChart');
	    if (pieChartCanvas) {
	        const existingChart = Chart.getChart(pieChartCanvas);
	        if (existingChart) {
	            existingChart.destroy();
	        }
	
	        new Chart(pieChartCanvas, {
	            type: 'pie',
	            data: datasetsConfig,
	            options: {
	                scales: {
	                    y: {
	                        beginAtZero: true
	                    }
	                }
	            }
	        });
	    }
	
	    // 更新長條圖
	    const barChartCanvas = document.getElementById('myChart2');
		    if (barChartCanvas) {
		        const existingChart = Chart.getChart(barChartCanvas);
		        if (existingChart) {
		            existingChart.destroy();
		        }
		
		    	 // 將 backgroundColor 設置為單一的白色值
		        const barChartConfig = {
		            labels: ['飲食', '交通', '娛樂', '日常用品', '醫療保健', '服飾', '稅金', '其他'],
		            datasets: [{
		                label: '金流',
		                data: chartData,
		                backgroundColor: '#5ab5ff',  
		                borderWidth: 1
		            }]
		        };
		        
		        new Chart(barChartCanvas, {
		            type: 'bar',
		            data: barChartConfig,
		            options: {
		                scales: {
		                    y: {
		                        beginAtZero: true
		                    }
		                }
		            }
		        });
		    }
	}
	
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