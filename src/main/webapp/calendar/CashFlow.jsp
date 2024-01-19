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
				<button class="month highlighted" onclick="dateSet(1); highlight(this)">1</button>
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
						<h1 id="cashIncome" class="cash_income_show show">${cashIncome}</h1>						
						<h1 class="cash_expense word">expense&nbsp:</h1>						
						<h1 id="cashExpense" class="cash_expense_show show">${cashExpense}</h1>
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
							<h1 id="bankIncome" class="mid_income_show show">${bankIncome}</h1>					
							<h1 class="mid_expense word">expense&nbsp:</h1>
							<h1 id="bankExpense" class="mid_expense_show show">${bankExpense}</h1>
						</div>
					</div>
			</div>
			<div class="bottom_outer">
				<div class="bottombar_right">
					<span class="icon-credit-card icon_card"></span>
					<div class="word_card">Credit Card</div>
				</div>
					<div class="card_wrapper">
						<h1 class="card_expense word">expense&nbsp:</h1>
						<h1  id="cardExpense" class="card_expense_show show">${cardExpense}</h1>
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
	

	<!-- 月份選擇 -->
	$(document).ready(function () {
	    fetchData();	    
	});
	
	var dataToSend; // 声明dataToSend变量
	
	function updateDate(year, month) {
	    console.log('Year:', year, 'Month:', month);
	}
	
	function dateSet(month) {
		updateDate(currentYear, month);
		fetchMoney(currentYear,month);		
	}
	
	function fetchData() {
	    var targetYear = 2024; // 設定初始年份
	    var targetMonth = 1; // 設定初始月份
	    fetchMoney(targetYear,targetMonth);
	}
		
	
	function fetchMoney(targetYear,targetMonth) {
		$.ajax({
			type : "POST",
			url : "/Calendar/CashFlow",
			dataType: 'json',
			data : {
				year: targetYear,
				month: targetMonth
			},
			success : function(data) {
				console.log("Data sent successfully:", data);
				console.log("Data sent successfully:", data.cashExpense);
				console.log("Data sent successfully:", data.cardExpense);
				console.log("Data sent successfully:", data.bankExpense);
				console.log("Data sent successfully:", data.cashIncome);
				console.log("Data sent successfully:", data.bankIncome);
				$('#cashExpense').text(data.cashExpense);
				$('#cardExpense').text(data.cardExpense);
				$('#bankExpense').text(data.bankExpense);
				$('#cashIncome').text(data.cashIncome);
				$('#bankIncome').text(data.bankIncome);
			},
			error : function(error) {
				console.error("Error sending data:", error);
			}
		});
	}	
</script>