<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String error = (String) request.getAttribute("error");
%>

<%@ include file="/calendar/fragements/header.jspf"%>

<link rel="stylesheet" href="/Calendar/css/record.css">
<style>
@font-face {
	font-family: BungeeInline;
	src: url(/Calendar/calendar/fontfamily/BungeeInline.ttf)
}
</style>
<div class="outer">
	<div class="record">
		<div class="record_bottombar">
			<%
			if (error != null) {
				out.print("<p class='text-center text-danger fw-bold'>" + error + "</p>");
			}
			%>
			<form method="post"
				action="${pageContext.request.contextPath }/Record">
				<div class="record_topbar">
					<button class="expense" type="button">Expense</button>
					<div class="date">
						Date: <input type="text" id="datepicker" name="datepicker"
							autocomplete="off">
					</div>
					<button class="income" type="button">Income</button>
				</div>
				<div class="name_block">
					<div class="name_left">Item Name :</div>
					<div class="name_bar">
						<input type="text" class="name_bar_a" id="name_bar_a"
							autocomplete="off" name="name_bar_a">
					</div>
				</div>
				<div class="type_block">
					<div class="type_left">Type :</div>
					<div class="type_bar">
						<select id="type_dropdown" name="type_dropdown">
							<option value>請選擇</option>
							<option value="101">飲食</option>
							<option value="102">交通</option>
							<option value="103">娛樂</option>
							<option value="104">日常用品</option>
							<option value="105">醫療保健</option>
							<option value="106">服飾</option>
							<option value="107">稅金</option>
							<option value="108">其他</option>
						</select>
					</div>
				</div>
				<div class="type_block_2">
					<div class="type_left_2">Type :</div>
					<div class="type_bar_2">
						<select id="type_dropdown_2" name="type_dropdown_2">
							<option value>請選擇</option>
							<option value="201">薪水</option>
							<option value="202">獎金</option>
							<option value="203">娛樂所得</option>
							<option value="204">其他</option>
						</select>
					</div>
				</div>
				<div class="amount_block">
					<div class="amount_left">Amount :</div>
					<div class="amount_bar">
						<input type="text" class="amount_bar_a" id="amount_bar_a"
							autocomplete="off" name="amount_bar_a">
					</div>
				</div>
				<div class="account_block">
					<div class="account_left">Account :</div>
					<div class="account_bar">
						<select id="account_dropdown" name="account_dropdown">
							<option value>請選擇</option>
							<option value="1">現金</option>
							<option value="2">信用卡</option>
							<option value="3">銀行</option>
						</select>
					</div>
				</div>
				<div class="note_block">
					<div class="note_left">Note :</div>
					<div class="note_bar">
						<input type="text" class="note_bar_a" id="note_bar_a"
							autocomplete="off" name="note_bar_a">
					</div>
				</div>

				<!-- Button trigger modal -->
				<div class="submit_block">
					<button type="button" class="submit_button" data-bs-toggle="modal"
						data-bs-target="#staticBackdrop" onclick="prepareModalContent()">Send</button>

					<!-- Modal -->
					<div class="modal fade" id="staticBackdrop"
						data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
						aria-labelledby="staticBackdropLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="staticBackdropLabel">確定要新增</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body" id="modalContent"></div>
								<div class="modal-footer">
									<button type="submit" class="btn btn-secondary"
										data-bs-dismiss="modal">確定</button>
									<button type="button" class="btn btn-primary"
										data-bs-dismiss="modal">返回</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>

<script>
	<!-- 日期選擇 -->
	$(function() {
		$("#datepicker").datepicker();
	});


	<!-- 支出 收入Type切換 -->

	$(function() {
		$('.type_block_2').hide();
		$('.type_block').show();
	});
	$('.income').on('click', function() {
		$('.type_block').hide();
		$('.type_block_2').show();
	});
	$('.expense').on('click', function() {
		$('.type_block_2').hide();
		$('.type_block').show();
	});



	function prepareModalContent() {
		// Get form input values
		var date = $("#datepicker").val();
		var itemName = $("#name_bar_a").val();
		var type1 = $("#type_dropdown option:selected").text();
		var type2 = $("#type_dropdown_2 option:selected").text();
		var amount = $("#amount_bar_a").val();
		var account = $("#account_dropdown option:selected").text();
		var note = $("#note_bar_a").val();

		var type2Text = $('.type_block_2').is(":hidden") ? '' : type2;
		var type1Text = $('.type_block').is(":hidden") ? '' : type1;

		// Build the HTML content for the modal
		var modalContentHTML = "Date: " + date + "<br>" + "Item Name: "
				+ itemName + "<br>" + "Type: " + type1Text + type2Text + "<br>"
				+ "Amount: " + amount + "<br>" + "Account: " + account + "<br>"
				+ "Note: " + note;

		// Set the content to the modal
		$("#modalContent").html(modalContentHTML);

	}
</script>

