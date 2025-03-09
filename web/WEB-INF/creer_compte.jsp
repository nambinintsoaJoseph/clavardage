<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/fontawesome/css/all.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/creation_compte.css" />
        <title>Créer un compte Clavardage.</title>
    </head>
    <body>
        <header>
            <div class="container-fluid row entete">
                <div class="col d-flex justify-content-start p-3">
                    <div class="text-light ms-3"> <i class="fa fa-comments"></i> Clavardage</div>
                </div>
                <div class="col d-flex justify-content-end p-2">
                    <div class="">
                        <a href="${pageContext.request.contextPath}/seconnecter" class="btn text-light ms-3"><i class="fa fa-user"></i> Se connecter</a>
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

        <div>
            <div>
                <h1 class="text-center">Création d'un compte Clavardage</h1>
            </div>

            <form method="POST" action="${pageContext.request.contextPath}/creer_compte" class="container">
                <div>
                    <label for="nom" class="form-label"><i class="fa fa-id-card"></i> Nom <span class="text-danger">*</span> </label>
                    <input type="text" name="nom" id="nom" class="form-control" autofocus="" />
                </div>

                <div>
                    <label for="prenom" class="form-label"><i class="fa fa-user"></i> Prénom(s) <span class="text-danger">*</span> </label>
                    <input type="text" name="prenom" id="prenom" class="form-control" />
                </div>

                <div>
                    <label for="date_naissance" class="form-label"><i class="fa fa-calendar"></i> Date de naissance <span class="text-danger">*</span> </label>
                    <input type="date" name="date_naissance" class="form-control" />
                </div>

                <div>
                    <label for="email" class="form-label"> <i class="fa fa-at"></i> Email <span class="text-danger">*</span> </label>
                    <input type="text" name="email" class="form-control" />
                </div>

                <div>
                    <label for="mot_passe" class="form-label"><i class="fa fa-lock"></i> Mot de passe <span class="text-danger">*</span> </label>

                    <div class="input-group">
                        <input type="password" name="mot_passe" class="form-control mot_passe" />
                    </div>

                </div>

                <div>
                    <label for="mot_passe" class="form-label"><i class="fa fa-lock"></i> Confirmation du mot de passe <span class="text-danger">*</span> </label>

                    <div class="input-group">
                        <input type="password" name="mot_passe" class="form-control mot_passe" />
                    </div>
                </div>
                <button class="btn btn-primary btn-creer"><i class="fa fa-user-plus"></i> Créer un compte</button>
            </form>
        </div>
    </body>
</html>
