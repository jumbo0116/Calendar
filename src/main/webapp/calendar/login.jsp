<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	String error = (String)request.getAttribute("error");

%>    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Login Page</title>
		<link rel="shortcut icon" type="image/x-icon" href="./images/icon.png">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet">
	    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
	    <link rel="stylesheet" href="/Calendar/css/login.css">
	    <link rel="stylesheet" href="/Calendar/css/style.css">
	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
	    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
	</head>
	<body>
	    <div class="d-flex justify-content-center align-items-center vh-100">
	    	<form class="needs-validation" novalidate method="post" action="/Calendar/login">
	    	  <h4 class="text-center">記帳本</h4>
	    	  <%
	    	  	if(error != null) {
	    	  		out.print("<p class='text-center text-danger fw-bold'>"+error+"</p>");
	    	  	}
	    	  %>
			  <div class="username">
			    <label for="username" class="form-label"></label>
			    <i class="icon-user-tie icon_home"></i>
			    <input type="text" class="form-control username_block" id="username" name="username" 
			    placeholder="帳號" value="" required>
			    <div class="invalid-feedback">
			      請輸入帳號
			    </div>
			  </div>
			  <div class="password">
			    <label for="password" class="form-label"></label>
			    <i class="icon-lock icon_lock"></i>
			    <input type="password" class="form-control password_block" id="password" name="password" 
			    placeholder="密碼" value="" required>
			    <div class="invalid-feedback">
			      請輸入密碼
			    </div>
			  </div>
			  <div class="d-flex justify-content-center btm_box">
			    <button class="btn  btn_left" type="submit">登入</button>
				<button  class="btn  btn_right" type="button" onclick="window.location.href='/Calendar/calendar/Register.jsp'">註冊帳號</button>
			  </div>			  
			</form>
			
	    </div>
	    

	</body>
</html>



<script type="text/javascript">
	//Example starter JavaScript for disabling form submissions if there are invalid fields
	(function () {
	  'use strict'
	
	  // Fetch all the forms we want to apply custom Bootstrap validation styles to
	  var forms = document.querySelectorAll('.needs-validation')
	
	  // Loop over them and prevent submission
	  Array.prototype.slice.call(forms)
	    .forEach(function (form) {
	      form.addEventListener('submit', function (event) {
	        if (!form.checkValidity()) {
	          event.preventDefault()
	          event.stopPropagation()
	        }
	
	        form.classList.add('was-validated')
	      }, false)
	    })
	})()
</script>





