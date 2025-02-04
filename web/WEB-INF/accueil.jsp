<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/fontawesome/css/all.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/accueil.css" />
        <title>Bienvenue sur Clavardage.</title>
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
                    <div class="">
                        <a href="" class="btn text-light ms-3"><i class="fa fa-user"></i> Se connecter</a>
                    </div>
                </div>
            </div>

        <nav class="d-flex justify-content-center mt-3">
            <ul class="nav">
                <li>
                    <a href="#" class="nav-link ms-4 text-dark"> <i class="fa fa-question-circle"></i> A propos</a>
                </li>
                <li>
                    <a href="#" class="nav-link ms-4 text-dark"> <i class="fa fa-newspaper"></i> Blog</a>
                </li>
                <li>
                    <a href="#" class="nav-link ms-4 text-dark"> <i class="fa fa-envelope"></i> Contact</a>
                </li>
            </ul>
        </nav>
    </header>

    <div class="bg-image d-flex align-items-center justify-content-center mt-3">
        <p class="text-light text-center h1 pub">
            Rencontrez des gens du monde entier ! <br>
            Accès gratuit et rapide.
        </p>
        
    </div>
    </body>
</html>
