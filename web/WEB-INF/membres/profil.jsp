<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/fontawesome/css/all.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profil.css" />
        
        <%-- Titre de la page : nom et prénom de l'utilisateur --%>
        <title> <c:out value="${ sessionScope.utilisateurConnecte.nom }" escapeXml="true" /> <c:out value="${ sessionScope.utilisateurConnecte.prenom }" escapeXml="true" />  </title>
        
        <style>
            .photo-profil {
                <%-- Si l'utilisateur a une photo de profil, on l'affiche. Dans le cas contraire, on affiche l'avatar par défaut --%>
                background-image: url("<c:choose><c:when test="${ !empty sessionScope.utilisateurConnecte.photo_profil}"><c:out value="${ pageContext.request.contextPath }/${sessionScope.utilisateurConnecte.photo_profil}" /></c:when><c:otherwise><c:out value="${pageContext.request.contextPath}/assets/default.png" /></c:otherwise></c:choose>");
                background-size: cover;
            }
        </style>
    </head>
    <body>
        <header>
            <div class="container-fluid row entete">
                <div class="col d-flex justify-content-start p-3">
                    <div class="text-light ms-3"> <i class="fa fa-comments"></i> Clavardage</div>
                </div>
                <div class="col d-flex justify-content-end p-2">
                    <div class="">
                        <a href="${pageContext.request.contextPath}/membre/deconnexion" class="btn text-light ms-3"><i class="fa fa-right-from-bracket"></i> Deconnexion</a>
                    </div>
                </div>
            </div>
        </header>
                    
        <main>
            
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <div class="container-fluid">
                    
                    <a class="navbar-brand" href="#"></a>
                    
                    <%-- Boutton du menu hamberger pour les petites écrans --%>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                      <span class="navbar-toggler-icon"></span>
                    </button>
                    
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                            <li class="nav-item">
                                <a class="nav-link" aria-current="page" href="#"> <i class="fa fa-envelope"></i> Messages</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link active" href="#"> <i class="fa fa-user"></i> Profil</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link"> <i class="fa fa-newspaper"></i> Notifications </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link"> <i class="fa fa-users"></i> Ami(e)s </a>
                            </li>
                        </ul>
                        
                        <form class="d-flex" method="POST" action="${pageContext.request.contextPath}/membre/recherche_personne">
                          <input name="nom" class="form-control me-2" type="search" placeholder="Trouver une personne" aria-label="Search">
                          <button class="btn btn-outline-success" type="submit"> <i class="fa fa-search"></i></button>
                        </form>
                    </div>
                </div>
            </nav>
            
            <%-- Message d'erreur (suppression de compte) --%>
            <c:if test="${!empty requestScope.error}">
                <div class="alert alert-danger alert-dismissible">
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    
                  
                        &ensp;&ensp;<i class="fa fa-triangle-exclamation"></i> <c:out value="${requestScope.error}" />
                    
                </div>
            </c:if>
            
            <%-- Photo de profil de l'utilisateur --%>
            <div class="container container-photo-profil mt-2">
                <%-- <img src="${pageContext.request.contextPath}/uploads/post.jpg" class="mx-auto d-block photo_profil" alt="Photo de profil" /> --%>
                <div class="photo-profil center"></div>
                <button class="btn btn-primary btn-photo-profil" data-bs-toggle="modal" data-bs-target="#modalModifierPhoto" > <i class="fa fa-camera"></i> </button>
            </div>
            
            <div class="container">
                <h3 class="text-center">
                    <c:out escapeXml="true" value="${ sessionScope.utilisateurConnecte.nom }" /> 
                    <c:out escapeXml="true" value="${ sessionScope.utilisateurConnecte.prenom }" />
                </h3>
                <div class="info mt-2">
                    
                    <%-- Parse de la date de naissance  --%>
                    <fmt:parseDate value="${ sessionScope.utilisateurConnecte.date_naissance }" pattern="yyyy-MM-dd" var="dateNaissance" />                  
                    
                    <%-- Récuperation du jour, mois, année --%>
                    <fmt:formatDate var="jour" value="${dateNaissance}" pattern="dd" />
                    <fmt:formatDate var="mois" value="${dateNaissance}" pattern="MM" />
                    <fmt:formatDate var="annee" value="${dateNaissance}" pattern="yyyy" />
                    
                    <p> 
                        <i class="fa fa-calendar"></i> 
                        Date de naissance : 
                        <c:out value="${jour}" />  
                        
                        <%-- Conversion du mois de naissance en lettre --%>
                        <c:choose>
                            <c:when test="${ mois == '01'}"> janvier </c:when>
                            <c:when test="${ mois == '02'}"> février </c:when>
                            <c:when test="${ mois == '03'}"> mars </c:when>
                            <c:when test="${ mois == '04'}"> avril </c:when>
                            <c:when test="${ mois == '05'}"> mai </c:when>
                            <c:when test="${ mois == '06'}"> juin </c:when>
                            <c:when test="${ mois == '07'}"> juillet </c:when>
                            <c:when test="${ mois == '08'}"> août </c:when>
                            <c:when test="${ mois == '09'}"> septembre </c:when>
                            <c:when test="${ mois == '10'}"> octobre </c:when>
                            <c:when test="${ mois == '11'}"> novembre </c:when>
                            <c:otherwise>décembre</c:otherwise>
                        </c:choose>
                        
                        <c:out value="${annee}" />
                    </p>
                    
                    <%-- Résidence --%>
                    <p> 
                        <i class="fa fa-house"></i> 
                        Résidence : 
                        <c:choose>
                            <c:when test="${ !empty sessionScope.utilisateurConnecte.residence }">
                                <c:out value="${ sessionScope.utilisateurConnecte.residence }" escapeXml="true" />
                            </c:when>
                            <c:otherwise>
                                -
                            </c:otherwise>
                        </c:choose>
                    </p>
                    
                    <%-- Etablissement --%>
                    <p> 
                        <i class="fa fa-graduation-cap"></i> 
                        Etablissement : 
                        <c:choose>
                            <c:when test="${ !empty sessionScope.utilisateurConnecte.info_scolaire }">
                                <c:out value="${ sessionScope.utilisateurConnecte.info_scolaire }" escapeXml="true" />
                            </c:when>
                            <c:otherwise>
                                -
                            </c:otherwise>
                        </c:choose>
                    </p>
                    
                    <%-- Emploi --%>
                    <p> 
                        <i class="fa fa-briefcase"></i> 
                        Emploi : 
                        <c:choose>
                            <c:when test="${ !empty sessionScope.utilisateurConnecte.info_professionnel }">
                                <c:out value="${ sessionScope.utilisateurConnecte.info_professionnel}" escapeXml="true" />
                            </c:when>
                            <c:otherwise>
                                -
                            </c:otherwise>
                        </c:choose>
                    </p>
                    
                    <%-- Adresse email --%>
                    <p> 
                        <i class="fa fa-at"></i> 
                        Adresse email : <a href="mailto:<c:out value="${ sessionScope.utilisateurConnecte.email }" escapeXml="true" />"><c:out value="${ sessionScope.utilisateurConnecte.email }" escapeXml="true" /></a>
                    </p>
                    
                    <div class="btn-action d-flex justify-content-around">
                        <button class="btn btn-primary text-center" data-bs-toggle="modal" data-bs-target="#modalModifierCompte" > <i class="fa fa-pencil"></i>  Modifier mes informations</button>
                        <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#modalSupprimerCompte"> <i class="fa fa-trash"></i>  Supprimer mon compte</button>
                    </div>
                </div>
            </div>
                
            <%-- Modal : modification du profil --%>
            <div class="modal fade" id="modalModifierCompte">
                <div class="modal-dialog">
                    <div class="modal-content">

                        <!-- En-tête -->
                        <div class="modal-header">
                            <h4 class="modal-title"> <i class="fa fa-user"></i> Modification des informations</h4>
                          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>

                        <!-- Corps -->
                        <div class="modal-body">
                            <form method="POST" action="${pageContext.request.contextPath}/membres/modifier_profil">
                                
                                <div>
                                    <label class="form-label"> <i class="fa fa-calendar"></i>  Date de naissance</label>
                                    <input type="date" name="date_naissance" class="form-control" value="<c:out value="${sessionScope.utilisateurConnecte.date_naissance}" />" />
                                </div>
                                
                                <div class="mt-3">
                                    <label> <i class="fa fa-house"></i>  Résidence</label>
                                    <input type="text" name="residence" class="form-control" placeholder="Votre ville" value="<c:out value="${ sessionScope.utilisateurConnecte.residence }" />" />
                                </div>
                                
                                <div class="mt-3">
                                    <label> <i class="fa fa-graduation-cap"></i> Etablissement</label>
                                    <input type="text" name="info_scolaire" class="form-control" placeholder="Nom de votre établissement" value="<c:out value="${ sessionScope.utilisateurConnecte.info_scolaire }" escapeXml="true" />"  />
                                </div>
                                
                                <div class="mt-3">
                                    <label>  <i class="fa fa-briefcase"></i> Emploi </label>
                                    <input type="text" name="info_professionnel" class="form-control" placeholder="Nom de votre organisation" value="<c:out value="${ sessionScope.utilisateurConnecte.info_professionnel}" escapeXml="true" />" />
                                </div>
                                
                                <div class="mt-3">
                                    <label>  <i class="fa fa-at"></i>  Adresse email </label>
                                    <input type="text" name="email" class="form-control" value="<c:out value="${ sessionScope.utilisateurConnecte.email }" escapeXml="true" />" />
                                </div>
                                
                                <div class="d-flex justify-content-end mt-3">
                                    <button type="submit" class="btn btn-success"> <i class="fa fa-check"></i> Valider</button>
                                    <button type="reset" class="btn btn-danger ms-2"> <i class="fa fa-trash"></i> Effacer</button>
                                </div>
                            </form>
                        </div>
                        
                    </div>
                </div>
            </div>
            
            <%-- Modal : Modification du photo de profil --%> 
            <div class="modal fade" id="modalModifierPhoto">
                <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                            <h4> <i class="fa fa-camera-retro"></i>  Personnalisez votre photo de profil</h4>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                    
                        <div class="modal-body">
                            <p>
                                    Pour mettre à jour votre photo de profil, sélectionnez une image depuis votre appareil. 
                                    Assurez-vous de choisir un fichier au format JPG, JPEG ou PNG.
                            </p>
                            <form method="POST" action="${pageContext.request.contextPath}/membres/modifier_photo" enctype="multipart/form-data">
                                <input class="form-control" type="file" name="photo_profil" />
                                
                                <div class="d-flex justify-content-end mt-2">
                                     <button class="btn btn-primary mt-2"  type="submit"> <i class="fa fa-images"></i> Changer ma photo de profil</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            
            <%-- Modal : confirmation de suppression de compte --%>
            <div class="modal fade" id="modalSupprimerCompte">
                <div class="modal-dialog">
                    <div class="modal-content">
                        
                        <div class="modal-header">
                            <h4 class="text-danger"> <i class="fa fa-trash"></i> Confirmation de suppression</h4>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        
                        <div class="modal-body">
                            <p>
                                Attention : La suppression de votre compte est une action définitive. Vous perdrez toutes vos conversations, 
                                ainsi que tout contact avec vos amis. Cette action est irréversible. Êtes-vous sûr de vouloir continuer ?
                            </p>
                            
                            <%-- Saisie du mot de passe pour confirmer la suppression du compte --%> 
                            <form method="POST" action="${pageContext.request.contextPath}/membres/supprimer_compte">
                                <div>
                                    <input type="password" name="mot_passe" placeholder="Saisir votre mot de passe" class="form-control" />
                                
                                    <div class="d-flex justify-content-end mt-3">
                                        <button class="btn btn-danger" type="submit"> <i class="fa fa-trash"></i> Supprimer</button>
                                        <a class="btn btn-success ms-2" data-bs-dismiss="modal"> <i class="fa fa-times"></i> Annuler</a>
                                    </div>
                                </div>
                            </form>
                            
                            
                        </div>
                        
                    </div>
                </div>
            </div>
                           
        </main>
                
        <srcipt src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript"></srcipt>
        <srcipt src="${pageContext.request.contextPath}/js/pooper.min.js" type="text/javascript"></srcipt>
        <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    </body>
</html>
