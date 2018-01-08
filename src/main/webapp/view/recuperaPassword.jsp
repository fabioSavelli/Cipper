<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
<head>
	<title>Cipper</title>
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/myStyle.css">
	
	<link rel="icon" type="image/png" href="images/favicon.png" /> 
	 
</head>
<body  id="sfondo">

	<nav class="navbar navbar-expand-lg fixed-top" style="background-color: #008250;"> 
		
		<div class="container-fluid">
	
		<div class="col-lg-1">
			<a class="navbar-brand col-3 font-weight-light"  id="linkDellaNavbar" id="home" href="index.jsp" > 
				<img src="images/logoBianco.png" width="30" height="30" class="d-inline-block align-top" alt="">  Cipper 
			</a>
		</div>
		
		<div class="col-lg-4 offset-lg-2">
			<s:if test="hasActionMessages()">
				<div class="alert alert-warning" role="alert" id="erroriNelLogin"> 
					<s:actionmessage/> 
				</div>
			</s:if>	
		</div>
		
		<div class="col-lg-5">
			<s:form action="login" method="post" class="form-inline my-2 my-lg-0 justify-content-between pagination-centered" >
				<div class="row">
					<input class="form-control col-md-5 font-weight-light" type="text" placeholder="email" name="utente.email" id="formDiLogin" value='<s:property value="utente.email"/>'>
					<input class="form-control col-md-5 font-weight-light" type="password" placeholder="password" name="utente.psw" id="formDiLogin"  >
			  		<button class="btn btn-outline-light col-md-2 col-offset-1 font-weight-light" type="submit" id="bottoneDiLogin"> Login </button>
				</div>
			</s:form>
			
			<a class="col-4 offset-2 offset-sm-3 offset-md-5 font-weight-light" id="recuperaPsw" href='<s:url action='recuperaPsw.action'/>' > 
				Non ricordo la password 
			</a>
		</div>
				
		</div>
	</nav>


	<div class="container-fluid">
	<div class="container">
	<br><br><br>
		
	<div class="row">
	
		<div class="col-lg-6 offset-lg-3 col-sm-12">
			<br>
			<h2 class="font-weight-light"><b>Recupera la tua password</b></h2>
			<h6 class="font-weight-light">Compila i seguenti campi per ricevere la tua nuova password</h6>
			<br><br>
			
			<s:form action="recuperaPassword" method="post" enctype="multipart/form-data">
				
				<s:set var="errori" value='errori'/>
				
				<%
					String validoUsername   = "is-valid";
					String validoEmail      = "is-valid";
					
					String messaggioUsername = "";
					String messaggioEmail    = "";
					
					String errori = (String)pageContext.getAttribute("errori");
					
					if(errori!=null && !errori.equals("")){	
						String[] arrayErrori = errori.split(" ");
						int i=0;
						for(i=0; i<arrayErrori.length; i++){
							if(arrayErrori[i].equals("1")){
								validoUsername    = "is-invalid";
								messaggioUsername = "inserisci username";
							}
							if(arrayErrori[i].equals("2")){
								validoEmail       = "is-invalid";
								messaggioEmail    = "inserisci email";
							}
							if(arrayErrori[i].equals("3")){
								validoEmail       = "is-invalid";
								messaggioEmail    = "non puoi recuperare la password di un account eliminato";
							}
							if(arrayErrori[i].equals("4")){
								validoEmail       = "is-invalid";
								messaggioEmail    = "le credenziali inserite non sono corrette";
							}
						}
					}
				%>
				
				<input class="form-control col-12 font-weight-light <%out.print(validoUsername);%>" type="text" placeholder="username" name="recupera.username" value='<s:property value="recupera.username"/>'>	
				<div class="invalid-feedback">
					<% out.print(messaggioUsername); %>
      			</div>
				<%
					if(validoUsername.equals("is-valid"))
						out.print("<br>");
				 %>
				<input class="form-control col-12 font-weight-light <%out.print(validoEmail);%>" type="text" placeholder="email" name="recupera.email" 		  value='<s:property value="recupera.email"/>'>
				<div class="invalid-feedback">
        				<% out.print(messaggioEmail); %>
      			</div>
				<%
					if(validoEmail.equals("is-valid"))
						out.print("<br>");
				 %>
				<button type="submit" class="btn btn-outline-success col-6 offset-3">Conferma</button>
			</s:form>
			<br><br><br>
		</div>
		<h6 class="text-muted font-weight-light col-lg-8 offset-lg-2" style="text-align: center;">
			Controlla la tua email per conoscere le tue nuove credenziali d'accesso.
			<br>
			Ricorda che in ogni momento puoi cambiare la tua password nell'apposita area del sito.
		</h6>
	</div>
	</div>
	</div>
	
	<script src="js/jquery.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	
</body>
</html>
