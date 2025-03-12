<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/fontawesome/css/all.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/resultat_recherche_personne.css" />
        <title>Résultat de recherche</title>
    </head>
    <body>
        <header>
            <div class="container-fluid row entete">
                <div class="col d-flex justify-content-start p-3">
                    <div class="text-light ms-3"> <i class="fa fa-comments"></i> Clavardage</div>
                </div>
                <div class="col d-flex justify-content-end p-2">
                    <div class="">
                        <a href="${pageContext.request.contextPath}/" class="btn text-light ms-3"><i class="fa fa-right-from-bracket"></i> Deconnexion</a>
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
                                <a class="nav-link" href="#"> <i class="fa fa-user"></i> Profil</a>
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
            
            <h2 class="text-center">Résultat</h2>
            
            <c:choose>
                <c:when test="${ not empty utilisateursTrouve }">
                    <div class="container resultat-recherche">
                        <c:forEach items="${ utilisateursTrouve }" var="utilisateur">
                            <div class="card">
                        
                                <%-- Affichage du photo de profil de manière conditionnel --%>
                                <c:choose>
                                    <%-- Si l'utilisateur n'a pas de photo de profil, on affiche l'avatar par défaut --%>
                                    <c:when test="${ empty utilisateur.photo_profil }">
                                        <img class="card-img-top" src="<c:out value="${ pageContext.request.contextPath }" />/assets/default.png" alt="" /> 
                                    </c:when>
                                    <c:otherwise>
                                        <img class="card-img-top" src="<c:out value="${ pageContext.request.contextPath }" />/<c:out value="${utilisateur.photo_profil}" />" alt="" /> 
                                    </c:otherwise>
                                </c:choose>
                              
                                <div class="card-body">
                                  <h4 class="card-title"> <c:out value="${ utilisateur.nom }" /> <c:out value="${ utilisateur.prenom }" /> </h4>
                                  
                                  <%-- Résidence --%>
                                  <p class="card-text"> 
                                      <c:if test="${not empty utilisateur.residence}">
                                            <i class="fa fa-house"></i> 
                                            <c:out value="${ utilisateur.residence }" /> 
                                      </c:if>
                                  </p>
                                  
                                  <%-- Info scolaire --%> 
                                  <p class="card-text"> 
                                      <c:if test="${not empty utilisateur.info_scolaire}">
                                            <i class="fa fa-graduation-cap"></i>  
                                            <c:out value="${ utilisateur.info_scolaire }" /> 
                                      </c:if>
                                  </p>
                                  
                                  <%-- Info professionnel --%>
                                  <p class="card-text"> 
                                      <c:if test="${not empty utilisateur.info_professionnel}">
                                            <i class="fa fa-briefcase"></i> 
                                            <c:out value="${ utilisateur.info_professionnel }" /> 
                                      </c:if>
                                  </p>
                                  
                                  <a href="#" class="btn btn-primary ajouter"> <i class="fa fa-user-plus"></i> Ajouter</a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <p class="text-center">Aucune personne n'a été trouvée.</p>
                </c:otherwise>
            </c:choose>
        </main>
                    
        <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    </body>
</html>
