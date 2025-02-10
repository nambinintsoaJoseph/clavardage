<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/fontawesome/css/all.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/information_profil.css" />
        <title>Information supplémentaire</title>
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
            <div class="alert alert-succes alert-dismissible fade bg-success show">
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                <div class="text-white">
                    <p class="text-center"> <i class="fa fa-circle-check"></i> Votre compte a été créé avec succès.</p>
                </div>
            </div>
            
            <form method="POST" action="${pageContext.request.contextPath}/information_profil" class="container">
                <div>
                    <label for="residence" class="form-label"> <i class="fa fa-house"></i> Résidence : </label>
                    <input type="text" name="residence" id="residence" class="form-control" placeholder="Nom de votre ville" />
                </div>
                
                <div>
                    <label for="info_scolaire" class="form-label"> <i class="fa fa-graduation-cap"></i> Information scolaire : </label>
                    <input type="text" name="info_scolaire" id="info_scolaire" class="form-control" placeholder="Nom de votre établissement" />
                </div>
                
                <div>
                    <label for="info_scolaire" class="form-label"> <i class="fa fa-briefcase"></i> Information professionnel : </label>
                    <input type="text" name="info_scolaire" id="info_scolaire" class="form-control" placeholder="Nom de votre organisation" />
                </div>
                
                <div>
                    <label for="photo_profil"> <i class="fa fa-image"></i> Photo de profil</label>
                    <input type="file" name="photo_profil" id="photo_profil" class="form-control">
                </div>
                
                <div class="mt-2">
                    <button type="submit" class="btn btn-primary btn-valider"> <i class="fa fa-check"></i> Valider</button>
                    <a class="btn btn-secondary"> <i class="fa fa-close"></i> Ignorer </a>
                </div>
            </form>
        </main>
                
        <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    </body>
</html>
