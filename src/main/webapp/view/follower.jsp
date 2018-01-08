<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="com.cipper.manager.LoginManager"%>
<%@ page import="com.cipper.manager.FollowerManager"%>
<%@ page import="com.cipper.model.Utente"%>
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

					<li class="nav-item"><s:form action="profilo">
							<input type="hidden" name="utente.idUtente"
								value='<s:property value="utente.idUtente" />'>
							<a class="nav-link font-weight-light" href="#"
								id="linkDellaNavbar" onclick="event.target.parentNode.submit();">
								<img src='<s:property value="utente.foto" />' id="fotoUtente"
								line-height="10px" width="30" height="30"
								class="d-inline-block align-top" alt=""> @<s:property
									value="utente.username" /> <span class="sr-only">(current)</span>
							</a>
						</s:form></li>

					<li class="nav-item"><a class="nav-link font-weight-light"
						href="#" id="linkDellaNavbar"> Follower </a></li>

					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle font-weight-light" href="#"
						id="linkDellaNavbar" id="navbarDropdown" role="button"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							altro </a>
						<div class="dropdown-menu dropdown-menu-right"
							aria-labelledby="navbarDropdown">
							
							<s:form action="ModificaProfilo">
								<input type="hidden" name="utente.idUtente" value='<s:property value="utente.idUtente" />'>
								<a class="dropdown-item font-weight-light" href="#" onclick="event.target.parentNode.submit();">Modifica foto</a> 
								<a class="dropdown-item font-weight-light" href="#" onclick="event.target.parentNode.submit();">Modifica password</a>
							</s:form>
							
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

	<div class="modal fade" id="eliminaModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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

			<br>
			<div class="col-lg-12 offset-lg-0">

				<br>

				<nav>
				<div class="nav nav-tabs" id="nav-tab" role="tablist">
					<a class="nav-item nav-link active col-5 offset-1"
						id="nav-seguo-tab" style="text-align: center;" data-toggle="tab"
						href="#nav-seguo" role="tab" aria-controls="nav-seguo"
						aria-selected="true"> <font color=" #008250">chi seguo</font>
					</a> <a class="nav-item nav-link col-5" id="nav-miSegue-tab"
						style="text-align: center;" data-toggle="tab" href="#nav-miSegue"
						role="tab" aria-controls="nav-miSegue" aria-selected="false">
						<font color=" #008250">chi mi segue</font>
					</a>
				</div>
				</nav>
				<div class="tab-content col-md-10" id="nav-tabContent">

					<s:set value='utente.idUtente' var="idUtente"></s:set>
					<%
						FollowerManager fm = new FollowerManager();
						LoginManager lm = new LoginManager();
						Utente utente = lm.read((Integer) pageContext.getAttribute("idUtente"));
						ArrayList<Utente> seguo = fm.seguo(utente.getIdUtente());
						ArrayList<Utente> miSeguono = fm.miSeguono(utente.getIdUtente());
					%>

					<div class="tab-pane fade show active" id="nav-seguo"
						role="tabpanel" aria-labelledby="nav-seguo-tab">

						<%
							int i;

							if (seguo.size() == 0) {

								out.println(
										"<br><div class='offset-md-3 alert alert-warning' role='alert' style='text-align: center;'>");
								out.println(
										"ATTENZIONE! Attualmente non stai seguendo nessuno, cerca altri utenti e seguili per restare sempre aggiornato sui cip della community.");
								out.println("</div>");
							}

							for (i = 0; i < seguo.size(); i++) {
								Utente attuale = seguo.get(i);

								String segui = "Segui";
								String classe = "btn-outline-success";

								if (fm.presente(utente.getIdUtente(), attuale.getIdUtente())) {
									segui = "✓ Segui";
									classe = "btn-success";
								}

								out.println("<br>");
								out.println("<div class='card border-success mb-3 col-lg-8 col-md-10 offset-lg-3 offset-md-1'>");

								out.println("<div class='card-body'>");
								out.println("<h4 class='row justify-content-center'>");

								//utente
								out.println("<form id='altri' name='altri' action='/cipperProva/altri.action' method='post'>");
								out.println("<input type='hidden' name='idUtente' value='" + utente.getIdUtente() + "'>");
								out.println("<input type='hidden' name='idAltro'  value='" + attuale.getIdUtente() + "'>");
								out.println("<input type='hidden' name='utente.idUtente' value='" + utente.getIdUtente() + "'>");
								out.println(
										"<a class='nav-link font-weight-light ' href='#' onclick='event.target.parentNode.submit();'>");
								out.println("<img src='" + attuale.getFoto()
										+ "' id='fotoUtente' line-height='10px' width='30' height='30' class='d-inline-block align-top' alt=''>");
								out.println("@" + attuale.getUsername());
								out.println("</a>");
								out.println("</form>");

								// bottone segui
								out.println("<form id='segui' name='segui' action='/cipperProva/segui.action' method='post'>");
								out.println("<input type='hidden' name='idUtente' value='" + utente.getIdUtente() + "'>");
								out.println("<input type='hidden' name='idAltro' value='" + attuale.getIdUtente() + "'>");
								out.println("<button type='submit' id='bottoneFollower' class='btn " + classe + " font-weight-light'>");
								out.println(segui);
								out.println("</button></form>");

								out.println("</h4>");
								out.println("</div>");
								out.println("</div>");
							}
						%>

					</div>
					<div class="tab-pane fade" id="nav-miSegue" role="tabpanel"
						aria-labelledby="nav-miSegue-tab">
						<%
							if (miSeguono.size() == 0) {

								out.println("<br><div class='offset-md-3 alert alert-warning' role='alert' style='text-align: center;'>");
								out.println("ATTENZIONE! Attualmente nessun utente ti sta seguendo, crea dei Cip interessanti per attirare l'attenzione di altri membri.");
								out.println("</div>");
							}

							for (i = 0; i < miSeguono.size(); i++) {
								Utente attuale = miSeguono.get(i);

								String segui = "Segui";
								String classe = "btn-outline-success";

								if (fm.presente(utente.getIdUtente(), attuale.getIdUtente())) {
									segui = "✓ Segui";
									classe = "btn-success";
								}

								out.println("<br>");
								out.println("<div class='card border-success mb-3 col-lg-8 col-md-10 offset-lg-3 offset-md-1'>");

								out.println("<div class='card-body'>");
								out.println("<h4 class='row justify-content-center'>");

								//utente
								out.println("<form id='altri' name='altri' action='/cipperProva/altri.action' method='post'>");
								out.println("<input type='hidden' name='idUtente' value='" + utente.getIdUtente() + "'>");
								out.println("<input type='hidden' name='idAltro'  value='" + attuale.getIdUtente() + "'>");
								out.println("<input type='hidden' name='utente.idUtente' value='" + utente.getIdUtente() + "'>");
								out.println(
										"<a class='nav-link font-weight-light ' href='#' onclick='event.target.parentNode.submit();'>");
								out.println("<img src='" + attuale.getFoto()
										+ "' id='fotoUtente' line-height='10px' width='30' height='30' class='d-inline-block align-top' alt=''>");
								out.println("@" + attuale.getUsername());
								out.println("</a>");
								out.println("</form>");

								// bottone segui
								out.println("<form id='segui' name='segui' action='/cipperProva/segui.action' method='post'>");
								out.println("<input type='hidden' name='idUtente' value='" + utente.getIdUtente() + "'>");
								out.println("<input type='hidden' name='idAltro' value='" + attuale.getIdUtente() + "'>");
								out.println("<button type='submit' id='bottoneFollower' class='btn " + classe + " font-weight-light'>");
								out.println(segui);
								out.println("</button></form>");

								out.println("</h4>");
								out.println("</div>");
								out.println("</div>");
							}
						%>
					</div>
				</div>
			</div>
		</div>
	</div>


	<script src="js/jquery.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>