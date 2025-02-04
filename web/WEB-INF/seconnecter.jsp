<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/fontawesome/css/all.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/accueil.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/seconnecter.css" />
        <title>Interface d'authentification</title>
    </head>
    <body>
        <header>
            <div class="container-fluid row entete">
                <div class="col d-flex justify-content-start p-3">
                    <div class="text-light ms-3"> <i class="fa fa-comments"></i> Clavardage</div>
                </div>
                <div class="col d-flex justify-content-end p-2">
                    <div class="">
                        <a href="${pageContext.request.contextPath}/creer_compte" class="btn text-light"> <i class="fa fa-user-plus"></i> Créer un compte</a>
                    </div>
                </div>
            </div>
        </header>
                    
        <main>
            <form method="POST" action="${pageContext.request.contextPath}/seconnecter" class="container">
                 <div>
                    <h1 class="text-center">Authentification</h1>
                </div>
                
                <c:if test="${erreurAuthentification}">
                    <div>
                        <p class="text-danger"> <i class="fa fa-warning"></i> Impossible de se connecter, adresse email ou mot de passe incorrecte.</p>
                    </div>
                </c:if>
                
                <div>
                    <label for="email" class="form-label"><i class="fa fa-at"></i> Email <span class="text-danger">*</span> </label>
                    <input type="text" name="email" id="email" class="form-control" autofocus="" />
                </div>
                
                <div>
                    <label for="mot_passe" class="form-label"><i class="fa fa-lock"></i> Mot de passe <span class="text-danger">*</span> </label>

                    <div class="input-group">
                        <input type="password" name="mot_passe" class="form-control mot_passe" />
                    </div>
                </div>
                
                <button type="submit" class="btn btn-seconnecter btn-primary mt-2"> <i class="fa fa-lock"></i> Se connecter </button>
            </form>
        </main>
    </body>
</html>
