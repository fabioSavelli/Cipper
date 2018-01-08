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
			<a class="navbar-brand col-3 font-weight-light"  id="linkDellaNavbar" id="home" href="#" > 
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
	
		<div class="col-lg-5 col-sm-12">
			<br>
			<h2 class="font-weight-light"><b>Crea il tuo nuovo account</b></h2>
			<h6 class="font-weight-light">è semplice e veloce</h6>
			<br>
			
			<s:form action="registrazione" method="post" enctype="multipart/form-data">
				
				<s:set var="errori" value='errori'/>
				
				<%
					String validoUsername   = "is-valid";
					String validoEmail      = "is-valid";
					String validoPassword   = "is-valid";
					String validoConfPass   = "is-valid";
					String validoFoto       = "is-valid";
					
					String messaggioUsername = "";
					String messaggioEmail    = "";
					String messaggioPassword = "";
					String messaggioConfPass = "";
					String messaggioFoto     = "";
					
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
								validoPassword    = "is-invalid";
								messaggioPassword = "inserisci una password";
							}
							if(arrayErrori[i].equals("4")){
								validoConfPass    = "is-invalid";
								messaggioConfPass = "le password non coincidono";
							}
							if(arrayErrori[i].equals("5")){
								validoEmail       = "is-invalid";
								messaggioEmail    = "email già presente";
							}
							if(arrayErrori[i].equals("6")){
								validoUsername    = "is-invalid";
								messaggioUsername = "username già presente";
							}
							if(arrayErrori[i].equals("7")){
								validoFoto        = "is-invalid";
								messaggioFoto     = "errore nel caricamento della foto";
							}
						}
					}
				%>
				
				<input class="form-control col-12 font-weight-light <%out.print(validoUsername);%>" type="text" placeholder="username" name="nuovoUtente.username" value='<s:property value="nuovoUtente.username"/>'>	
				<s:fielderror fieldName="nuovoUtente.username"/>
				<div class="invalid-feedback">
					<% out.print(messaggioUsername); %>
      			</div>
				<%
					if(validoUsername.equals("is-valid"))
						out.print("<br>");
				 %>
				<input class="form-control col-12 font-weight-light <%out.print(validoEmail);%>" type="text" placeholder="email" name="nuovoUtente.email" 		  value='<s:property value="nuovoUtente.email"/>'>
				<div class="invalid-feedback">
        				<% out.print(messaggioEmail); %>
      			</div>
				<%
					if(validoEmail.equals("is-valid"))
						out.print("<br>");
				 %>
				<input class="form-control col-12 font-weight-light <%out.print(validoPassword);%>" type="password" placeholder="nuova password" name="nuovoUtente.psw" value='<s:property value="nuovoUtente.psw"/>'>
				<div class="invalid-feedback">
        				<% out.print(messaggioPassword); %>
      			</div>
				<%
					if(validoPassword.equals("is-valid"))
						out.print("<br>");
				 %>
				<input class="form-control col-12 font-weight-light <%out.print(validoConfPass);%>" type="password" placeholder="conferma password" name="confPassword" value='<s:property value="confPassword"/>'>
				<div class="invalid-feedback">
        				<% out.print(messaggioConfPass); %>
      			</div>
				<%
					if(validoConfPass.equals("is-valid"))
						out.print("<br>");
				 %>		
				 
				<div class="row">	
					<div class="input-group col-12">
                			<label class="input-group-btn <%out.print(validoFoto);%>">
                    			<span class="btn btn-outline-success">
                        			Foto 
                        			<input type="file" style="display: none;" accept="image/*" name="userImage" value="<s:property value="userImage"/>">
                    			</span>
                			</label>
                			<input type="text" class="form-control font-weight-light" readonly value="<s:property value="userImageFileName"/>">
            			</div>
					<div class="invalid-feedback">
        					<% out.print(messaggioFoto); %>
      				</div>
      			</div>
				<%
					if(validoFoto.equals("is-valid"))
						out.print("<br>");
				 %>	
				<button type="submit" class="btn btn-outline-success col-6 offset-3">Crea account</button>
				<br>
			</s:form>
		</div>
	
	
		<div class="col-lg-6 col-sm-12 offset-lg-1">
			<br><br>
			<div id="carosello" id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" data-interval="5000">
  				
  				<div class="carousel-inner" id="carosello">
    					<div class="carousel-item active">
      					<img class="d-block w-100 img-thumbnail" src="images/slide1.png" alt="First slide" id="imgCarosello">
      					<div id="testoCarosello" style="text-align: center;">
      						<h4 class="font-weight-light"><b><br>Home page</b></h4>
      						<h6 class="font-weight-light">dove troverai alucuni cip selezionati appositamente per te</h6>
      					</div>
      				</div>
    					<div class="carousel-item" id="carosello">
      					<img class="d-block w-100 img-thumbnail" src="images/slide2.png" alt="Second slide" id="imgCarosello">
      					<div id="testoCarosello" style="text-align: center;">
      						<h4 class="font-weight-light"><b><br>profilo</b></h4>
      						<h6 class="font-weight-light">dove puoi creare e visualizzare tutti i tuoi cip</h6>
      					</div>
      				</div>
    					<div class="carousel-item" id="carosello">
      					<img class="d-block w-100 img-thumbnail" src="images/slide3.png" alt="Third slide" id="imgCarosello">
      					<div id="testoCarosello" style="text-align: center;">
      						<h4 class="font-weight-light"><b><br>follower</b></h4>
      						<h6 class="font-weight-light">dove puoi ricercare le persone che segui</h6>
      					</div>
    					</div>
  				</div>
			</div>
			<br>
		</div>
	</div>
	</div>
	</div>
	
	<script src="js/jquery-1.11.1.js"></script>
	<script src="js/caricaFoto.js"></script>
	<script src="js/jquery.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	
</body>
</html>
