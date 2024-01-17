<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
<link rel="shortcut icon" type="image/x-icon" href="./images/icon.png">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="/Calendar/css/register.css">
<link rel="stylesheet" href="/Calendar/css/style.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
</head>
<body>
	<div class="d-flex justify-content-center align-items-center vh-100">
		<form class="needs-validation" novalidate method="post"
			action="/Calendar/Register">
			<h4 class="text-center">註冊帳號</h4>
			<%
			if (error != null) {
				out.print("<p class='text-center text-danger fw-bold'>" + error + "</p>");
			}
			%>
			<div class="username">
				<label for="username" class="form-label"></label> 
				<i class="icon-user-plus icon_home"></i>
				<input type="text"
					class="form-control username_block" id="username" name="username" placeholder="帳號"
					value="" required>
			</div>
			<div class="password">
				<label for="password" class="form-label"></label>
				<i class="icon-lock icon_lock"></i> 
				<input type="password" class="form-control password_block" id="password" name="password"
					placeholder="密碼" value="" required>
			</div>
			<div class="password_confirm">
				<label for="password" class="form-label"></label>
				<i class="icon-unlocked icon_unlock"></i>  
				<input type="password" class="form-control password_unblock" id="comfirm" name="comfirm"
					placeholder="確認密碼" value="" required>
			</div>
			<div class="d-flex justify-content-center">
			<!-- Button trigger modal -->
			<button type="button" class="btn btn_left" data-bs-toggle="modal"
				data-bs-target="#staticBackdrop">註冊</button>
			<button class="btn  btn_right" type="button"
				onclick="window.location.href='/Calendar/calendar/login.jsp'">返回登入</button>
				
			<!-- Modal -->
			<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
				data-bs-keyboard="false" tabindex="-1"
				aria-labelledby="staticBackdropLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="staticBackdropLabel"></h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">確定要註冊帳號?</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-secondary"
								data-bs-dismiss="modal">確定</button>
							<button type="button" class="btn btn-primary"
								onclick="window.location.href='/Calendar/calendar/Register.jsp'">返回</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>

</body>
</html>



<script type="text/javascript">
	//Example starter JavaScript for disabling form submissions if there are invalid fields
	(function() {
		'use strict'

		// Fetch all the forms we want to apply custom Bootstrap validation styles to
		var forms = document.querySelectorAll('.needs-validation')

		// Loop over them and prevent submission
		Array.prototype.slice.call(forms).forEach(function(form) {
			form.addEventListener('submit', function(event) {
				if (!form.checkValidity()) {
					event.preventDefault()
					event.stopPropagation()
				}

				form.classList.add('was-validated')
			}, false)
		})
	})()
</script>




