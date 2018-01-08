<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="com.cipper.manager.CipManager"%>
<%@ page import="com.cipper.manager.LoginManager"%>
<%@ page import="com.cipper.model.Utente"%>
<%@ page import="com.cipper.model.Cip"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="icon" type="image/png" href="images/favicon.png" />

<title>Cipper</title>

<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/myStyle.css">

</head>
<body>
	<nav class="navbar navbar-expand-lg fixed-top"
		style="background-color: #008250;">

	<div class="container-fluid">

		<div class="col-lg-1">
			<s:form action="home">
				<input type="hidden" name="utente.idUtente"
					value='<s:property value="utente.idUtente" />'>
				<a class="navbar-brand col-3 font-weight-light" id="linkDellaNavbar"
					id="home" href="#" onclick="event.target.parentNode.submit();">
					<img src="images/logoBianco.png" width="30" height="30"
					class="d-inline-block align-top" alt=""> Cipper
				</a>
				<a class="navbar-toggler col-3 offset-6" data-toggle="collapse"
					data-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation"> <img
					src="images/menuBianco.png" width="30" height="30"
					class="d-inline-block align-top" alt="">
				</a>
			</s:form>
		</div>


		<div class="col-lg-5 offset-lg-1">
			<form
				class="form-inline my-2 my-lg-0 justify-content-between pagination-centered"
				action="cerca">
				<input type="hidden" name="utente.idUtente"
					value='<s:property value="utente.idUtente" />'> <input
					class="form-control col-8 font-weight-light" name="usernameAltro"
					type="search" placeholder="Search" aria-label="Search">
				<button
					class="btn btn-outline-light col-3 col-offset-1 font-weight-light"
					type="submit">cerca</button>
			</form>
		</div>

		<div class="col-lg-4 offset-lg-1">
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav navbar-brand">

					<li class="nav-item">
						<s:form action="profilo">
							<input type="hidden" name="utente.idUtente" value='<s:property value="utente.idUtente" />'>
							<a class="nav-link font-weight-light" href="#" id="linkDellaNavbar" onclick="event.target.parentNode.submit();">
								<img src='<s:property value="utente.foto" />' id="fotoUtente" line-height="10px" width="30" height="30" class="d-inline-block align-top" alt=""> 
								@<s:property value="utente.username" /> <span class="sr-only">(current)</span>
							</a>
						</s:form>
					</li>

					<li class="nav-item">
						<s:form action="follower">
							<input type="hidden" name="utente.idUtente"
								value='<s:property value="utente.idUtente" />'>
							<a class="nav-link font-weight-light" href="#"
								id="linkDellaNavbar" onclick="event.target.parentNode.submit();">
								Follower </a>
						</s:form>
					</li>

					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle font-weight-light" href="#"
						id="linkDellaNavbar" id="navbarDropdown" role="button"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							altro </a>
						<div class="dropdown-menu dropdown-menu-right"
							aria-labelledby="navbarDropdown">
							
							<a class="dropdown-item font-weight-light" href="#">Modifica foto</a> 
							<a class="dropdown-item font-weight-light" href="#">Modifica password</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item font-weight-light" data-toggle="modal"
								data-target="#eliminaModal" href="#">Elimina account</a>
							<div class="dropdown-divider font-weight-light"></div>
							<s:form action="logout">
								<button type="submit" class="dropdown-item font-weight-light">Esci</button>
							</s:form>
						</div></li>
				</ul>
			</div>
		</div>
	</nav>

	<br>

	<div class="modal fade" id="eliminaModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title font-weight-light" id="exampleModalLabel">
						<b>Elimina Account</b>
					</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<s:form action="EliminaAccount">
					<input type="hidden" name="utente.idUtente"
						value='<s:property value="utente.idUtente" />'>
					<div class="modal-body">
						Sei sicuro di voler eliminare il tuo account?<br>
						<br>Ricorda che puoi sempre decidere di riattivarlo creando
						un nuovo account con le tue vecchie credenziali.<br>
					</div>
					<div class="modal-footer">
						<div class='btn-group'>
						<button type="button"
							class="btn btn-secondary btn-lg font-weight-light"
							data-dismiss="modal">annulla</button>
						<button type="submit"
							class="btn btn-danger btn-lg font-weight-light">Conferma</button>
						</div>
					</div>
				</s:form>
			</div>
		</div>
	</div>

	<div class="container-fluid" id="sfondo">
		<div class="container">
			
			<h2 class="offset-1">
				<img src='<s:property value="utente.foto" />' id="fotoUtente" line-height="10px" width="50" height="50" class="d-inline-block align-top" alt=""> 
				@<s:property value="utente.username" /> <span class="sr-only">(current)</span>
			</h2>
			
			<s:if test="hasActionMessages()">
				<div class="alert alert-success col-md-8 offset-md-2" role="alert" id="erroriNelLogin" style="text-align: center;">
					<s:actionmessage />
				</div>
			</s:if>
			<s:else>
				<br><br>
			</s:else>
			
			<div class="col-md-6 offset-md-3">
				<h5>Modifica qui la tua password</h5><br>
				
				<s:form action="ModificaPassword">
					<input type="hidden" name="utente.idUtente" value='<s:property value="utente.idUtente" />'>
					<s:set var="errori" value='errori'/>
				
				<%
					String validoPassword   = "is-valid";
					String validoConfPass   = "is-valid";
					
					String messaggioPassword = "";
					String messaggioConfPass = "";
					
					String errori = (String)pageContext.getAttribute("errori");
					
					if(errori!=null && !errori.equals("")){	
						String[] arrayErrori = errori.split(" ");
						int i=0;
						for(i=0; i<arrayErrori.length; i++){
							if(arrayErrori[i].equals("1")){
								validoPassword    = "is-invalid";
								messaggioPassword = "inserisci una password";
							}
							if(arrayErrori[i].equals("2")){
								validoConfPass    = "is-invalid";
								messaggioConfPass = "le password non coincidono";
							}
						}
					}
				%>
				
					<input class="form-control col-12 font-weight-light <%out.print(validoPassword);%>" type="password" placeholder="nuova password" name="password" value='<s:property value="password"/>'>
					<div class="invalid-feedback">
        					<% out.print("<font class='font-weight-light' color='#D21E37'>"+messaggioPassword+"</font><br>"); %>
      				</div>
					<%
						if(validoPassword.equals("is-valid"))
							out.print("<br>");
				 	%>
				 	
				 	<input class="form-control col-12 font-weight-light <%out.print(validoConfPass);%>" type="password" placeholder="conferma password" name="confPassword" value='<s:property value="confPassword"/>'>
					<div class="invalid-feedback">
        					<% out.print("<font class='font-weight-light' color='#D21E37'>"+messaggioConfPass+"</font><br>"); %>
      				</div>
					<%
						if(validoConfPass.equals("is-valid"))
							out.print("<br>");
				 	%>		
				 
				 	<button type="submit" class="btn btn-outline-success col-4 offset-4"> Conferma </button>
				 	<br><br><br>
				 </s:form>
				
				<h5>Modifica qui la tua foto</h5><br>
				
				<s:form action="ModificaFoto" method="post" enctype="multipart/form-data">
					<input type="hidden" name="utente.idUtente" value='<s:property value="utente.idUtente" />'>
					<s:set var="errori2" value='errori2'/>
					<s:set var="userImageFileName" value='userImageFileName'/>
				<%
					String validoFoto     = "is-valid";
					String validoFotoBtn  = "btn-outline-success";
					String messaggioFoto  = "";
					String valueInputText = (String)pageContext.getAttribute("userImageFileName");
					
					if(valueInputText != null && !valueInputText.equals("")){
						valueInputText = valueInputText.split("-")[1];
					}
					else {
						valueInputText = "inserisci una immagine";
					}
					if(valueInputText.equals("null")){
						out.print("'"+valueInputText+"'");
						valueInputText = "inserisci una immagine";
						out.print("'"+valueInputText+"'");
					}
					
					
					String errori2 = (String)pageContext.getAttribute("errori2");
					
					if(errori2!=null && !errori2.equals("")){	
						String[] arrayErrori2 = errori2.split(" ");
						int i=0;
						for(i=0; i<arrayErrori2.length; i++){
							if(arrayErrori2[i].equals("1")){
								validoFoto    = "is-invalid";
								validoFotoBtn = "btn-outline-danger";
								messaggioFoto = "inserisci una foto";
							}
						}
					}
				%>
				
					<div class="input-group <%out.print(validoFoto);%>">
                			<label class="input-group-btn">
                    			<span class="btn <%out.print(validoFotoBtn);%>">
                        			Foto 
                        			<input type="file" style="display: none;" accept="image/*" name="userImage" value="<s:property value="userImage"/>">
                    			</span>
                			</label>
                			<input type="text" class="form-control font-weight-light <%out.print(validoFoto);%>" readonly value="<% out.print(valueInputText); %>">
            			</div>
					<%
					if(validoFoto.equals("is-valid"))
						out.print("<br>");
					else
						out.print("<font class='font-weight-light' color='#D21E37'>"+messaggioFoto+"</font><br>");
				 	%>			
				 
      				<button type="submit" class="btn btn-outline-success col-4 offset-4"> Conferma </button>
				 
				 </s:form>
			
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