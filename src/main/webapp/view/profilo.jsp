<%@page import="com.cipper.manager.ReCipManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="com.cipper.manager.CipManager"%>
<%@ page import="com.cipper.manager.ReCipManager"%>
<%@ page import="com.cipper.manager.LoginManager"%>
<%@ page import="com.cipper.model.Utente"%>
<%@ page import="com.cipper.model.Cip"%>
<%@ page import="com.cipper.model.ReCip"%>
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

					<li class="nav-item"><a class="nav-link font-weight-light"
						href="#" id="linkDellaNavbar"> <img
							src='<s:property value="utente.foto" />' id="fotoUtente"
							line-height="10px" width="30" height="30"
							class="d-inline-block align-top" alt=""> @<s:property
								value="utente.username" /> <span class="sr-only">(current)</span></a>
					</li>

					<li class="nav-item"><s:form action="follower">
							<input type="hidden" name="utente.idUtente"
								value='<s:property value="utente.idUtente" />'>
							<a class="nav-link font-weight-light" href="#"
								id="linkDellaNavbar" onclick="event.target.parentNode.submit();">
								Follower </a>
						</s:form></li>

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

			<br>
			<div class="row">
			<div class="col-lg-4 offset-lg-1">
				<h2 class="row font-weight-light">
					<a href="#" data-toggle="modal" data-target="#fotoModal">
					<img src='<s:property value="utente.foto" />' id="fotoUtente" line-height="0px" width="50" height="50" class="d-inline-block align-top" alt=""></a> 
					<a href="#">@<s:property value="utente.username"/></a>
				</h2>
				<br>
				
				<!-- Modal -->
				<div class="modal fade bd-example-modal-lg" id="fotoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-lg" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title font-weight-light" id="exampleModalLabel">
									<b>immagine del profilo</b>
								</h5>
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
								<div class="modal-body">
								<img src='<s:property value="utente.foto" />' line-height="0px" width="100%" height="100%" class="d-inline-block align-top" alt=""></a>
								</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-4 offset-lg-2">
				
				<!-- Button trigger modal -->
				<button type="button" class="btn btn-outline-success btn-lg btn-block font-weight-light" data-toggle="modal" data-target="#exampleModal">
					Crea un cip
				</button>

				<!-- Modal -->
				<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title font-weight-light" id="exampleModalLabel">
									<b>Crea qui il tuo nuovo cip</b>
								</h5>
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<s:form action="nuovoCipProfilo">
								<input type="hidden" name="utente.idUtente" value='<s:property value="utente.idUtente" />'>
								<div class="modal-body">
									<textarea class="form-control font-weight-light" name="nuovoCip.testo" rows="5" maxLength="150" id="comment" placeholder="Fai sapere a tutti quello che stai pensando"></textarea>
								</div>
								<div class="modal-footer">
									<div class='btn-group'>
										<button type="button" class="btn btn-secondary btn-lg font-weight-light" data-dismiss="modal"> 
											annulla
										</button>
										<button type="submit"class="btn btn-success btn-lg font-weight-light">
											pubblica
										</button>
									</div>
								</div>
							</s:form>
						</div>
					</div>
				</div>
			</div>
			</div>

			<br>
			<s:set value='utente.idUtente' var="idUtente"></s:set>

			<nav>
				<div class="nav nav-tabs" id="nav-cip-tab" role="tablist">
					<a class="nav-item nav-link active col-5 offset-1"
						id="nav-seguo-tab" style="text-align: center;" data-toggle="tab"
						href="#nav-cip" role="tab" aria-controls="nav-cip"
						aria-selected="true"> <font color=" #008250">i miei Cip</font> </a> 
						
					<a class="nav-item nav-link col-5" id="nav-reCip-tab"
						style="text-align: center;" data-toggle="tab" href="#nav-reCip"
						role="tab" aria-controls="nav-reCip" aria-selected="false">
						<font color=" #008250">i miei ReCip</font> </a>
				</div>
			</nav>

			<div class="tab-content col-md-10" id="nav-tabContent">

				<div class="tab-pane fade show active" id="nav-cip"
						role="tabpanel" aria-labelledby="nav-cip-tab">
				<br><br>
			<%
				CipManager cm = new CipManager();
				LoginManager lm = new LoginManager();
				Utente utente = lm.read((Integer) pageContext.getAttribute("idUtente"));
				ArrayList<Cip> altroCip = cm.getAllMyCip(utente.getIdUtente());

				if (altroCip.size() == 0) {
					out.println("<div class='alert alert-warning col-md-12 offset-md-1' role='alert' style='text-align: center;'>");
					out.println("ATTENZIONE! Non hai ancora pubblicato nessun Cip.");
					out.println("</div>");
				}

				int i;
				for (i = 0; i < altroCip.size(); i++) {
					Cip attuale = altroCip.get(i);

					String azione = "/cipperProva/altri.action";
					if (utente.getIdUtente() == attuale.getIdAutore())
						azione = "/cipperProva/profilo.action";

					boolean mioLike = cm.mioLike(utente.getIdUtente(), attuale.getIdCip());
					String like = "likeNo.png";
					if (mioLike)
						like = "likeSi.png";

					out.println("<div class='card border-success mb-3 col-lg-10 offset-lg-2 col-10 offset-1'>");

					out.println("<div class='card-body'>");

					//titolo
					out.println("<h3 class='card-title'>");
					out.println("<form id='altri' name='altri' action='" + azione + "' method='post'>");
					out.println("<input type='hidden' name='idUtente' value='" + utente.getIdUtente() + "'>");
					out.println("<input type='hidden' name='idAltro'  value='" + attuale.getIdAutore() + "'>");
					out.println("<input type='hidden' name='utente.idUtente' value='" + utente.getIdUtente() + "'>");
					out.println(
							"<a class='card-title nav-link font-weight-light' href='#' onclick='event.target.parentNode.submit();'>");
					out.println("<img src='" + lm.getFoto(attuale.getIdAutore())
							+ "' id='fotoUtente' line-height='10px' width='40' height='40' class='d-inline-block align-top' alt=''>");
					out.println("@" + lm.getUsername(attuale.getIdAutore()));
					out.println("</a>");
					out.println("</form>");
					out.println("</h3>");

					//data
					out.println("<h5 class='card-subtitle mb-2 text-muted font-weight-light col-md-5'>"
							+ cm.stampaData(attuale.getData()) + "</h5>");

					//testo
					out.println("<h6><p class='card-text font-weight-light'>");
					out.println("<br>" + cm.stampaTesto(attuale.getTesto()));
					out.println("</p></h6><br>");

					//bottoni like e share
					out.println("<div class='row justify-content-end'>");
					out.println("<div class='btn-group role='group' aria-label='Basic example'>");
					
					out.println("<input type='hidden' id='idUtente' value='"+utente.getIdUtente()+"'>");
					out.println("<input type='hidden' id='idCip"+i+"' value='"+attuale.getIdCip()+"'>");
					out.println("<a class='btn btn-outline-success' id='like"+i+"'>");
					out.println("<img src='images/"+like+"' id='fotoLike"+i+"' line-height='5px' width='25' height='25' class='d-inline-block align-top' alt=''>");
					out.println("<font class='font-weight-light' id='likeText"+i+"' color='#008250'>"+attuale.getLikes() + "</font></a>");
					
					out.println("<a class='btn btn-outline-success' id='share' data-toggle='modal' data-target='#reCipModal"+i+"' href='#'>");
					out.println("<img src='images/share.png' id='fotoUtente' line-height='0px' width='25' height='25' class='d-inline-block align-top' alt=''>");
					out.println("<font class='font-weight-light' color='#008250'>"+attuale.getShares() + "</font></a>");
					

					// Modal reCip
					out.println("<div class='modal fade' id='reCipModal"+i+"' tabindex='-1' role='dialog' aria-labelledby='exampleModalLabel' aria-hidden='true'>");
					out.println("<div class='modal-dialog' role='document'>");
					out.println("<div class='modal-content'>");
					out.println("<div class='modal-header'>");
					out.println("<h5 class='modal-title font-weight-light' id='exampleModalLabel'>");
					out.println("<b>Conferma il tuo ReCip</b></h5>");
					out.println("<button type='button' class='close' data-dismiss='modal' aria-label='Close'>");
					out.println("<span aria-hidden='true'>&times;</span></button></div>");
					
					out.println("<form id='reCipProfilo' name='reCipProfilo' action='/cipperProva/reCipProfilo.action' method='post'>");
					out.println("<input type='hidden' name='utente.idUtente' value='"+utente.getIdUtente()+"'>");
					out.println("<input type='hidden' name='cip.idCip' value='"+attuale.getIdCip()+"'>");
					
					out.println("<div class='modal-body'>");
					out.println("<h4 class='font-weight-light'><img src='"+lm.getFoto(attuale.getIdAutore())+"' id='fotoUtente' line-height='10px' width='35' height='35' class='d-inline-block align-top' alt=''>");
					out.println("@"+lm.getUsername(attuale.getIdAutore())+"</h4>");
					
					out.println("<h6 class='card-subtitle mb-2 text-muted font-weight-light col-10 offset-1'>"+cm.stampaData(attuale.getData())+"</h6>");
					
					out.println("<br><div class='col-12 offset-0 font-weight-light'>"+cm.stampaTesto(attuale.getTesto())+"</div><br></div>");
					
					out.println("<div class='modal-footer justify-content-between'>");
					out.println("<h6 class='card-subtitle mb-2 text-muted font-weight-light' id='condPens'>condividi il pensiero di altri</h6>");
					
					out.println("<div class='btn-group'><button type='button' class='btn btn-secondary btn-lg font-weight-light' data-dismiss='modal'>annulla</button>");
					out.println("<button type='submit' class='btn btn-success btn-lg font-weight-light'>Conferma</button></div>");
					out.println("</div> </form> </div> </div> </div> </div>");
		
					out.println("</div>");
					out.println("</div>");
					out.println("</div>");
					out.println("<br>");
				}
				int quantiCip = i;
			%>
			
				</div>
				<div class="tab-pane fade" id="nav-reCip" role="tabpanel" aria-labelledby="nav-reCip-tab">
					<br><br>
				
				<%
					ReCipManager rcm = new ReCipManager();
					ArrayList<ReCip> tuttiReCip = rcm.getAllMyReCip(utente);
					
					if(tuttiReCip.size() == 0){
						out.println("<div class='alert alert-warning col-md-12 offset-md-1' role='alert' style='text-align: center;'>");
						out.println("ATTENZIONE! Non hai ancora effettuale alcun recip.");
						out.println("</div>");
					}
					
					for(i=0; i<tuttiReCip.size(); i++){
						ReCip reCipAttuale = tuttiReCip.get(i);
						Cip cipAttuale = cm.read(reCipAttuale.getIdCip());
						
						String stampaData = "ha effettuato un recip il giorno: "+cm.stampaData(reCipAttuale.getDataReCip());
						
						String azione = "/cipperProva/altri.action";
						if (utente.getIdUtente() == cipAttuale.getIdAutore())
							azione = "/cipperProva/profilo.action";

						String azione2 = "/cipperProva/altri.action";
						if (utente.getIdUtente() == reCipAttuale.getIdUtente())
							azione2 = "/cipperProva/profilo.action";

						
						boolean mioLike = cm.mioLike(utente.getIdUtente(), cipAttuale.getIdCip());
						String like = "likeNo.png";
						if (mioLike)
							like = "likeSi.png";
					
						//reCip
						out.println("<div class='card border-success mb-3 col-lg-10 offset-lg-2 col-10 offset-1'>");
						out.println("<h3 class='card-title'>");
						out.println("<form id='altri' name='altri' action='" + azione2 + "' method='post'>");
						out.println("<input type='hidden' name='idUtente' value='" + utente.getIdUtente() + "'>");
						out.println("<input type='hidden' name='idAltro'  value='" + cipAttuale.getIdAutore() + "'>");
						out.println("<input type='hidden' name='utente.idUtente' value='" + utente.getIdUtente() + "'>");
						out.println("<a class='card-title nav-link font-weight-light' href='#' onclick='event.target.parentNode.submit();'>");
						out.println("<img src='"+lm.getFoto(reCipAttuale.getIdUtente())+"' id='fotoUtente' line-height='10px' width='40' height='40' class='d-inline-block align-top' alt=''>");
						out.println("@" + lm.getUsername(reCipAttuale.getIdUtente()));
						out.println("</a>");
						//data recip
						out.println("<h5 class='card-subtitle mb-2 text-muted font-weight-light col-md-10'>"+stampaData+"</h5>");
						out.println("</form>");
						out.println("</h3>");
						
						//cip interrno 
						out.println("<div class='card border-success mb-3 col-lg-11 offset-lg-1 col-11 offset-1'>");
						out.println("<div class='card-body'>");

						//titolo
						out.println("<h3 class='card-title'>");
						out.println("<form id='altri' name='altri' action='" + azione + "' method='post'>");
						out.println("<input type='hidden' name='idUtente' value='" + utente.getIdUtente() + "'>");
						out.println("<input type='hidden' name='idAltro'  value='" + cipAttuale.getIdAutore() + "'>");
						out.println("<input type='hidden' name='utente.idUtente' value='" + utente.getIdUtente() + "'>");
						out.println("<a class='card-title nav-link font-weight-light' href='#' onclick='event.target.parentNode.submit();'>");
						out.println("<img src='" + lm.getFoto(cipAttuale.getIdAutore())+"' id='fotoUtente' line-height='10px' width='40' height='40' class='d-inline-block align-top' alt=''>");
						out.println("@" + lm.getUsername(cipAttuale.getIdAutore()));
						out.println("</a>");
						out.println("</form>");
						out.println("</h3>");

						//data
						out.println("<h5 class='card-subtitle mb-2 text-muted font-weight-light col-md-5'>"+cm.stampaData(cipAttuale.getData())+"</h5>");

						//testo
						out.println("<h6><p class='card-text font-weight-light'>");
						out.println("<br>" + cm.stampaTesto(cipAttuale.getTesto()));
						out.println("</p></h6><br>");

						//bottoni like e share
						out.println("<div class='row justify-content-end'>");
						out.println("<div class='btn-group role='group' aria-label='Basic example'>");
						
						out.println("<input type='hidden' id='idUtenteReCip' value='"+utente.getIdUtente()+"'>");
						out.println("<input type='hidden' id='idCipReCip"+i+"' value='"+cipAttuale.getIdCip()+"'>");
						out.println("<a class='btn btn-outline-success' id='ReCipLike"+i+"'>");
						out.println("<img src='images/"+like+"' id='fotoLikeReCip"+i+"' line-height='5px' width='25' height='25' class='d-inline-block align-top' alt=''>");
						out.println("<font class='font-weight-light' id='likeTextReCip"+i+"' color='#008250'>"+cipAttuale.getLikes() + "</font></a>");
						
						out.println("<a class='btn btn-outline-success' id='share' data-toggle='modal' data-target='#reCipModal"+i+"b' href='#'>");
						out.println("<img src='images/share.png' id='fotoUtente' line-height='0px' width='25' height='25' class='d-inline-block align-top' alt=''>");
						out.println("<font class='font-weight-light' color='#008250'>"+cipAttuale.getShares() + "</font></a>");
						
						// Modal reCip
						out.println("<div class='modal fade' id='reCipModal"+i+"b' tabindex='-1' role='dialog' aria-labelledby='exampleModalLabel' aria-hidden='true'>");
						out.println("<div class='modal-dialog' role='document'>");
						out.println("<div class='modal-content'>");
						out.println("<div class='modal-header'>");
						out.println("<h5 class='modal-title font-weight-light' id='exampleModalLabel'>");
						out.println("<b>Conferma il tuo ReCip</b></h5>");
						out.println("<button type='button' class='close' data-dismiss='modal' aria-label='Close'>");
						out.println("<span aria-hidden='true'>&times;</span></button></div>");
						
						out.println("<form id='reCipProfilo' name='reCipProfilo' action='/cipperProva/reCipProfilo.action' method='post'>");
						out.println("<input type='hidden' name='utente.idUtente' value='"+utente.getIdUtente()+"'>");
						out.println("<input type='hidden' name='cip.idCip' value='"+cipAttuale.getIdCip()+"'>");
						
						out.println("<div class='modal-body'>");
						out.println("<h4 class='font-weight-light'><img src='"+lm.getFoto(cipAttuale.getIdAutore())+"' id='fotoUtente' line-height='10px' width='35' height='35' class='d-inline-block align-top' alt=''>");
						out.println("@"+lm.getUsername(cipAttuale.getIdAutore())+"</h4>");
						
						out.println("<h6 class='card-subtitle mb-2 text-muted font-weight-light col-10 offset-1'>"+cm.stampaData(cipAttuale.getData())+"</h6>");
						
						out.println("<br><div class='col-12 offset-0 font-weight-light'>"+cm.stampaTesto(cipAttuale.getTesto())+"</div><br></div>");
						
						out.println("<div class='modal-footer justify-content-between'>");
						out.println("<h6 class='card-subtitle mb-2 text-muted font-weight-light' id='condPens'>condividi il pensiero di altri</h6>");
						
						out.println("<div class='btn-group'><button type='button' class='btn btn-secondary btn-lg font-weight-light' data-dismiss='modal'>annulla</button>");
						out.println("<button type='submit' class='btn btn-success btn-lg font-weight-light'>Conferma</button></div>");
						out.println("</div> </form> </div> </div> </div> </div>");
			
						out.println("</div>");
						out.println("</div>");
						out.println("</div>");
						
						out.println("</div>");
						out.println("<br>");
					}
					int quantiReCip = i;
					
				%>
						
				</div>
			</div>
		</div>
	</div>

	<script src="js/jquery-1.11.1.js"></script>
	<script type="text/javascript">
	
	$(document).ready(function() {
		<%
			// per i like nei cip
			for(i=0; i<quantiCip; i++){
				out.println("    $('#like"+i+"').click(function(e) {");
				out.println("            e.preventDefault();");
				out.println("            var idUtente = $('#idUtente').val();");
				out.println("            var idCip  = $('#idCip"+i+"').val();");
				out.println("            var value = 'dati='+idUtente+' '+idCip;");
				out.println("");
				out.println("            $.ajax({");
				out.println("                url: 'like',");
				out.println("                data: value,");
				out.println("                cache: false,");
				out.println("");
				out.println("                success: function(data) {");
				out.println("                    if(document.getElementById('fotoLike"+i+"').getAttribute('src') == 'images/likeSi.png'){");
				out.println("                        document.getElementById('likeText"+i+"').textContent = parseInt(document.getElementById('likeText"+i+"').textContent, 10) - 1;");
				out.println("                        $('#fotoLike"+i+"').attr('src', 'images/likeNo.png');");
				out.println("                    }");
				out.println("                    else{");
				out.println("                        document.getElementById('likeText"+i+"').textContent = parseInt(document.getElementById('likeText"+i+"').textContent, 10) + 1;");
				out.println("                        $('#fotoLike"+i+"').attr('src', 'images/likeSi.png');");
				out.println("                    }");
				out.println(""); 
				out.println("                }");
				out.println("            });"); 
				out.println("    });");
			}
		
			// per i like nei recip
			for(i=0; i<quantiReCip; i++){
				out.println("    $('#ReCipLike"+i+"').click(function(e) {");
				out.println("            e.preventDefault();");
				out.println("            var idUtente = $('#idUtenteReCip').val();");
				out.println("            var idCip  = $('#idCipReCip"+i+"').val();");
				out.println("            var value = 'dati='+idUtente+' '+idCip;");
				out.println("");
				out.println("            $.ajax({");
				out.println("                url: 'like',");
				out.println("                data: value,");
				out.println("                cache: false,");
				out.println("");
				out.println("                success: function(data) {");
				out.println("                    if(document.getElementById('fotoLikeReCip"+i+"').getAttribute('src') == 'images/likeSi.png'){");
				out.println("                        document.getElementById('likeTextReCip"+i+"').textContent = parseInt(document.getElementById('likeTextReCip"+i+"').textContent, 10) - 1;");
				out.println("                        $('#fotoLikeReCip"+i+"').attr('src', 'images/likeNo.png');");
				out.println("                    }");
				out.println("                    else{");
				out.println("                        document.getElementById('likeTextReCip"+i+"').textContent = parseInt(document.getElementById('likeTextReCip"+i+"').textContent, 10) + 1;");
				out.println("                        $('#fotoLikeReCip"+i+"').attr('src', 'images/likeSi.png');");
				out.println("                    }");
				out.println(""); 
				out.println("                }");
				out.println("            });"); 
				out.println("    });");
			}
		%>
 		});

	</script>

	<script src="js/jquery.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>