<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/fontawesome/css/all.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ami.css" />
        <title>Liste d'amis</title>
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
                                <a class="nav-link" href="${pageContext.request.contextPath}/membres/profil"> <i class="fa fa-user"></i> Profil</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link"> <i class="fa fa-newspaper"></i> Notifications </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link active"> <i class="fa fa-users"></i> Ami(e)s </a>
                            </li>
                        </ul>
                        
                        <form class="d-flex" method="POST" action="${pageContext.request.contextPath}/membres/recherche_personne">
                          <input name="nom" class="form-control me-2" type="search" placeholder="Trouver une personne" aria-label="Search">
                          <button class="btn btn-outline-success" type="submit"> <i class="fa fa-search"></i></button>
                        </form>
                    </div>
                </div>
            </nav>
            
            <h2 class="text-center">Liste d'amis</h2>
            
            <c:choose>
                <c:when test="${not empty amis}">
                    <div class="container liste-amis">
                        <c:forEach items="${ amis }" var="ami">
                            <div class="card">
                        
                                <%-- Affichage du photo de profil de manière conditionnel --%>
                                <c:choose>
                                    <%-- Si l'utilisateur n'a pas de photo de profil, on affiche l'avatar par défaut --%>
                                    <c:when test="${ empty ami.photo_profil }">
                                        <img class="card-img-top" src="<c:out value="${ pageContext.request.contextPath }" />/assets/default.png" alt="" /> 
                                    </c:when>
                                    <c:otherwise>
                                        <img class="card-img-top photo-ami" src="<c:out value="${ pageContext.request.contextPath }" />/<c:out value="${ami.photo_profil}" />" alt="" /> 
                                    </c:otherwise>
                                </c:choose>
                        
                                <div class="card-body">
                                  <h4 class="card-title"> <c:out value="${ ami.nom }" /> <c:out value="${ ami.prenom }" /> </h4>
                                  
                                  <%-- Résidence --%>
                                  <p class="card-text"> 
                                      <c:if test="${not empty ami.residence}">
                                            <i class="fa fa-house"></i> 
                                            <c:out value="${ ami.residence }" /> 
                                      </c:if>
                                  </p>
                                  
                                  <%-- Info scolaire --%> 
                                  <p class="card-text"> 
                                      <c:if test="${not empty ami.info_scolaire}">
                                            <i class="fa fa-graduation-cap"></i>  
                                            <c:out value="${ ami.info_scolaire }" />
                                      </c:if>
                                  </p>
                                  
                                  <%-- Info professionnel --%>
                                  <p class="card-text"> 
                                      <c:if test="${not empty ami.info_professionnel}">
                                            <i class="fa fa-briefcase"></i> 
                                            <c:out value="${ ami.info_professionnel }" /> 
                                      </c:if>
                                  </p>
                                  
                                  <a class="btn btn-primary btn-retirer"> <i class="fa fa-user-xmark"></i> Retirer de la liste d'amis </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <p class="text-center">La liste d'amis est vide.</p>
                </c:otherwise>
            </c:choose>
        </main>
    </body>
</html>
