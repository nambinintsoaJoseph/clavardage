<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                                <a class="nav-link" aria-current="page" href="${pageContext.request.contextPath}/membres/messages"> <i class="fa fa-envelope"></i> Messages</a>
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
                                  
                                  <button type="button" class="btn btn-primary btn-retirer" data-bs-toggle="modal" data-bs-target="#confirmationSuppression">
                                        <i class="fa fa-user-xmark"></i> Retirer de la liste d'ami
                                  </button>
                                </div>
                            </div>
                            
                            <%-- Confirmation du suppression --%>
                            <div class="modal" id="confirmationSuppression">
                                <div class="modal-dialog">
                                    <div class="modal-content">

                                        <!-- Modal Header -->
                                        <div class="modal-header">
                                            <h4 class="modal-title text-danger"> Confirmer la suppression d'ami </h4>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                        </div>

                                        <!-- Modal body -->
                                        <div class="modal-body">
                                            <p>
                                                Etes-vous sûr de vouloir retirer 
                                                <c:out value="${ ami.nom }" /> <c:out value="${ ami.prenom }" />
                                                de votre liste d'amis ? <span class="text-danger">Cette action est irréversible.</span>
                                            </p>
                                            
                                            <div class="d-flex justify-content-end">
                                                <a class="btn btn-primary btn-retirer" href="${pageContext.request.contextPath}/membres/retirer_ami?id_ami_utilisateur=<c:out value="${ami.id_utilisateur}" />"> <i class="fa fa-user-xmark"></i> Retirer </a>
                                   
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="d-flex justify-content-center">
                        <svg xmlns="http://www.w3.org/2000/svg" width="150" height="150" viewBox="0 0 731.67004 404.48722" xmlns:xlink="http://www.w3.org/1999/xlink" role="img" artist="Katerina Limpitsouni" source="https://undraw.co/"><path d="m0,403.29721c0,.66003.53003,1.19,1.19006,1.19h729.28998c.65997,0,1.19-.52997,1.19-1.19,0-.65997-.53003-1.19-1.19-1.19H1.19006c-.66003,0-1.19006.53003-1.19006,1.19Z" fill="#3f3d56"/><g><g><path d="m254.28441,136.56316l6.24486-21.88741,9.10519,4.68633,44.02066-16.29033,7.3895-3.13454c2.19034-2.9221,5.04874-5.27629,8.33542-6.86685,8.16702-4.09051,16.89795-3.19262,19.50061,2.00561,2.60223,5.19743-1.90823,12.72595-10.07855,16.81723-3.24185,1.67881-6.83789,2.55702-10.4884,2.56105l-25.16998,12.21292-34.14407,16.87912-14.71524-6.98312.00002-.00002Z" fill="#ffb6b6"/><path d="m237.52126,107.22835l1.26518,17.13948,19.17975,18.81966,1.5928-4.12425,3.45837-8.93571,4.56055-11.82621,1.0473-2.70511-15.03419-17.31421-12.48038-14.38003c-2.94591,7.37593-4.16794,15.35063-3.58942,23.32639h.00003Z" fill="#e6e6e6"/></g><g><path d="m342.8161,67.05564s-1.92297-6.2735.62973-11.12093c2.5527-4.84744,5.48288-10.44408,5.48288-10.44408,0,0,4.52045,1.22757,2.37277,10.7549,0,0,6.21829-12.78117,8.66437-11.60406s1.73022,4.35289,1.73022,4.35289h0c2.09753-.28929,4.17059.67409,5.30191,2.46391l-3.38336,7.79958s9.08792-7.63669,10.14462-6.77277c1.0567.86391,2.64667,7.1252,2.64667,7.1252,0,0,4.02017-1.17949,5.78131.26037,1.76114,1.43986-4.53552,10.86642-4.53552,10.86642,1.80707-2.87057,4.2417-3.39121,7.26642-1.69959,0,0-3.58652,14.52181-13.36279,14.40376-3.35071-.04046-10.73141,5.20404-15.03781,2.86733-8.2583-4.48104-13.70148-19.25292-13.70148-19.25292h.00006Z" fill="#6c63ff"/><path d="m354.38565,68.93363c-2.73645-7.29115-4.12012-9.48021-4.12012-9.48021,0,0-7.0365-1.16903-7.98752,6.7509l-1.49268-2.63077s-2.37418,5.71301,5.55664,16.0612c8.58163,11.19739,18.01297,8.37919,18.91473,6.76663,0,0,13.67603,2.24856,18.65866-10.60258l-4.45618-.58737-13.90308,7.08599.24197-5.0791c.15939-3.34557-3.65564-5.35902-6.32773-3.3396,0,0-2.34821,2.34607-5.08466-4.94508,0,0-.00006,0-.00006,0Z" fill="#3f3d56"/><path d="m332.25,124.03945c-.40579-.23152-.63162-.70751-.52271-1.18755,4.37531-19.41145,18.40802-41.75336,18.54916-41.97705.32236-.50912,1.0014-.66511,1.50555-.33943.50867.32211.66113.99544.33923,1.50483-.13953.22091-13.97336,22.25188-18.26627,41.29206-.13196.5871-.71582.95684-1.30356.82389-.10892-.02411-.20929-.06422-.30139-.11675,0,0-.00003,0-.00003,0Z" fill="#3f3d56"/></g><g><path d="m385.80981,95.36458c2.69843,1.54869,4.98663,3.72038,6.67349,6.33462l10.58267,6.4468,31.84167,17.92227,12.17566,13.79799-11.08347,9.43527-39.2262-27.9752-11.34094-7.72119c-3.10446-.2219-6.11035-1.1841-8.76566-2.80694-6.69931-3.96508-10.08243-10.63644-7.55838-14.89845,2.52466-4.26286,10.00034-4.5027,16.70114-.53518,0,0,0,.00002,0,.00002Z" fill="#ffb6b6"/><polygon points="434.90384 126.06932 438.70047 146.99425 439.16928 149.61305 482.48196 121.651 485.74374 108.35131 485.72244 108.23198 482.27472 92.1281 434.90384 126.06932" fill="#e6e6e6"/></g><g><polygon points="217.01125 386.60315 228.0555 389.98511 246.35811 348.99597 230.05795 344.00409 217.01125 386.60315" fill="#ffb6b6"/><path d="m254.92584,397.9433h0c.16646.68448-.22469,2.60925-.43098,3.28275h0c-.63412,2.07013-2.82635,3.23428-4.89656,2.60013l-34.20174-10.47684c-1.41223-.43259-2.20645-1.92816-1.77383-3.34045l.43617-1.42392s-.38097-4.79791,4.71825-9.00577c0,0,3.06415,5.45651,11.51501.96899l2.96635-2.87158,10.71552,14.32944,7.36562,3.28683c1.61145.71906,3.16907.93576,3.58604,2.65039l.00014.00003h.00002Z" fill="#2f2e41"/></g><g><polygon points="330.34756 396.82044 341.5675 394.07712 336.32779 349.49417 319.76807 353.54257 330.34756 396.82044" fill="#ffb6b6"/><path d="m368.72723,387.17075h0c.49316.50299,1.14163,2.35699,1.30884,3.04123h0c.51401,2.10318-.77423,4.22488-2.87747,4.73892l-34.74771,8.49231c-1.43478.35065-2.88223-.52817-3.23291-1.96301l-.35355-1.44666s-2.78156-3.92786-.55234-10.15189c0,0,5.42404,3.12128,10.3902-5.0575l1.08005-3.9848,16.53729,6.83173,8.01035-.94336c1.7525-.20642,3.20175-.81696,4.4371.44308l.00015-.00003v-.00003Z" fill="#2f2e41"/></g><g><polygon points="453.79465 395.75946 440.84686 395.75818 434.6875 345.8161 453.79727 345.81745 453.79465 395.75946" fill="#ffb6b6"/><path d="m409.43384,395.46573h0c-.40314.67899-.61588,2.87042-.61588,3.66h0c0,2.427,1.96744,4.39453,4.39453,4.39453h40.09784c1.6557,0,2.99796-1.34219,2.99796-2.99796v-1.6694s1.98361-5.01743-2.10028-11.20166c0,0-5.07571,4.84235-12.66016-2.74207l-2.23657-4.05173-16.18979,11.84039-8.97375,1.10458c-1.96326.24164-3.70389-.03751-4.71378,1.66333h-.00015l.00003-.00003Z" fill="#2f2e41"/></g><g><polygon points="496.61044 385.95017 484.05991 389.13285 465.80881 342.23883 484.33212 337.54102 496.61044 385.95017" fill="#ffb6b6"/><path d="m453.53952,396.57392h0c-.22382.75726.10889,2.93372.30304,3.69907h0c.5968,2.35248,2.98767,3.77579,5.34024,3.17899l38.86664-9.86014c1.60486-.40714,2.57587-2.03821,2.1687-3.64313l-.41052-1.61813s.6889-5.35114-4.79031-10.34125c0,0-3.72913,5.9418-12.94571.45529l-3.16425-3.37735-12.7811,15.45792-8.42661,3.27734c-1.84357.71698-3.5994.87445-4.16003,2.77139l-.00015.00003.00006-.00003Z" fill="#2f2e41"/></g><path d="m433.91086,161.79938l37.09381,4.36398,6.54596,16.36491s14.18292,16.36491-4.36398,48.00374l-6.54596,50.18573,24.32819,77.20746-27.05661,1-25.77075-73.74304-11.86761-63.37811-1.091-25.09286,8.72794-34.9118h.00003Z" fill="#2f2e41"/><polygon points="436.09286 218.53107 426.2739 221.80405 429.96887 358.9252 459.96887 358.9252 436.09286 218.53107" fill="#2f2e41"/><path d="m314.44702,192.8927l25.09286,169.1041-18.54691,1.091-35.45731-104.18994-9.49118,51.38086-34.69409,50.62711-17.4559-4.36398,27.63789-71.91556-6.90901-53.54877s-7.63696-24.00186,0-34.9118,69.82364-3.27298,69.82364-3.27298v-.00003Z" fill="#2f2e41"/><polygon points="478.09613 56.51843 478.64163 77.79283 462.8222 82.7023 456.82175 77.79283 455.18527 59.79141 478.09613 56.51843" fill="#ffb6b6"/><polygon points="258.8063 58.70042 265.35226 40.15352 290.44513 57.60943 284.99017 72.88334 258.8063 58.70042" fill="#ffb6b6"/><path d="m426.03418,129.0802l3.49084,15.601,3.93835,17.61998,37.95572,4.46201,11.06284-45.11218,3.26181-13.29969-.0213-.11933-3.44772-16.10388-3.19681-14.88078h-22.50708l-24.25278,27.43893c-3.98203,4.51633-6.36057,10.17906-6.85175,16.06979-.22906,2.76051-.04367,5.56471.56787,8.32416Z" fill="#e6e6e6"/><circle cx="460.64023" cy="42.33551" r="24.00187" fill="#ffb6b6"/><circle cx="288.26315" cy="34.69855" r="24.00187" fill="#ffb6b6"/><path d="m237.52126,107.22835l1.26518,17.13948,5.31326,72.03758.14169.14169c.09856.10974,10.28827,10.00433,26.82791,1.19008,15.96112-8.5106,47.22919,3.18562,47.54507,3.30495l.96048.36011-7.61566-33.28598-5.48746-23.94754-3.9277-17.20447-4.17859-18.23047-8.54205-37.32287-34.54105-15.60207-12.04462,23.39138c-.78575,1.53847-1.50545,3.09825-2.12712,4.70172-2.94591,7.37593-4.16794,15.35063-3.58942,23.32639,0,0,.00006.00002.00006.00002Z" fill="#e6e6e6"/><path d="m297.53659,31.97106l3.27298-2.18199v-7.63696s15.27393,3.27298,12.00095-8.72795c-3.27298-12.00094-18.42477-14.43894-30.54785-13.09193-.49094.05455-.9819.10364-1.47162.14769-11.70074,1.05245-21.21854,9.94302-22.66254,21.60191-1.56851,12.66415-.93906,26.1721,8.86023,26.25414l9.81894,3.27298s-4.36398-20.72889,4.36398-16.36491,16.3649-3.27298,16.3649-3.27298c0,0,.00003,0,.00003,0Z" fill="#2f2e41"/><g><path d="m325.88464,64.32493s-4.77917-4.49602-4.96417-9.9714-.41342-11.78855-.41342-11.78855c0,0,4.53467-1.17393,7.39069,8.16553,0,0-.93286-14.18292,1.77509-14.37271s3.65994,2.92337,3.65994,2.92337h0c1.6785-1.29074,3.95651-1.4813,5.82611-.48736l.92651,8.45116s4.10904-11.13666,5.45496-10.90994c1.34592.22671,5.82983,4.87715,5.82983,4.87715,0,0,2.90729-3.01673,5.15051-2.63887s1.44559,11.6859,1.44559,11.6859c.14703-3.38881,2.00366-5.04754,5.46915-5.0772,0,0,4.08133,14.39057-4.46854,19.13281-2.93039,1.62535-6.74203,9.83818-11.64047,9.94269-9.39355.20041-21.44177-9.93257-21.44177-9.93258Z" fill="#6c63ff"/><path d="m336.86429,60.22266c-5.99002-4.97681-8.27667-6.19245-8.27667-6.19245,0,0-6.69104,2.47166-3.59222,9.82197l-2.60022-1.54529s.76901,6.13871,12.78571,11.19662c13.00278,5.47299,19.798-1.64866,19.78207-3.49616,0,0,12.99292-4.82431,10.95212-18.45565l-4.16159,1.69815-8.56424,13.04456-2.30685-4.53147c-1.5195-2.98485-5.83093-2.84309-7.15109.23512,0,0-.87698,3.20143-6.867-1.77538v-.00002Z" fill="#3f3d56"/><path d="m344.94638,119.05562c-.46719,0-.89923-.30151-1.04251-.77243-5.81934-19.02847-4.70279-45.38813-4.69107-45.65235.02771-.60196.54016-1.07395,1.13947-1.04092.60144.0277,1.06754.53697,1.04037,1.13894-.01172.26103-1.10965,26.25205,4.59729,44.91721.17633.57533-.14755,1.18582-.72397,1.36161-.10654.03303-.21362.04794-.31964.04794,0,0,.00006,0,.00006,0Z" fill="#3f3d56"/></g><g><path d="m253.15669,145.2033l19.84993-5.19775.54166,9.21596,32.84122,26.68405,5.82324,4.29576c3.27261.35878,6.41107,1.49655,9.15353,3.31709,6.92188,4.46043,10.23154,11.64752,7.39212,16.05251-2.83902,4.40427-10.75079,4.35892-17.67477-.10371-2.79034-1.74525-5.12198-4.13274-6.80026-6.96362l-21.02704-13.92728-28.76595-18.74979-1.33372-14.62323.00005.00002Z" fill="#ffb6b6"/><polygon points="266.04703 77.7927 283.61456 87.76771 280.32938 150.60887 246.71101 156.22209 266.04703 77.7927" fill="#e6e6e6"/></g><g><path d="m456.25827,190.16532c1.90915-2.45665,4.37814-4.42036,7.20169-5.72701l7.85678-9.58253,22.17908-29.03769,15.35815-10.13701,7.80106,12.28868-33.16187,34.95135-9.2243,10.15607c-.65176,3.04337-2.02292,5.88611-3.99948,8.28975-4.8588,6.08234-11.93607,8.5041-15.80533,5.41151-3.87003-3.09334-3.0672-10.52963,1.79422-16.61311v-.00002Z" fill="#ffb6b6"/><polygon points="465.34491 92.0131 486.07053 77.20957 517.40479 144.87862 493.49585 145.81809 465.34491 92.0131" fill="#e6e6e6"/></g><path d="m440.45682,29.78908s3.66409-7.58397,5.62805-1.98393,12.43842,19.60015,12.43842,19.60015c0,0,5.56454,7.77784-.65466,14.31122s-19.63959,38.26694-.98199,32.97802c18.65762-5.28893,28.15009,7.15561,28.15009,7.15561,0,0,16.039,1.24445,13.74771-14.93345s-14.07504-26.75576-14.07504-46.3559-11.12909-28.00021-17.67563-27.06687-30.50485,1.05059-26.57697,16.29514c0,0,.00003.00002.00003.00002Z" fill="#2f2e41"/></g></svg>
                    </div>
                    <p class="text-center">La liste d'amis est vide.</p>
                </c:otherwise>
            </c:choose>
            
            <!-- Demandes d'amis -->
            <div class="container mt-4">
                <button class="btn w-100 text-start btn-demande-ami" type="button" data-bs-toggle="collapse" data-bs-target="#demandeAmi">
                    <i class="fa fa-user-clock"></i> Demande d'ami 
                    
                    <!-- Nombre demande(s) -->
                    <c:if test="${(fn:length(demandes)) >= 1}">
                        <span class="badge">
                            ${fn:length(demandes)}
                        </span>
                    </c:if>
                    
                </button>
                
                <div class="collapse mt-3" id="demandeAmi">
                    <div class="card card-body">
                        <c:choose>
                            <c:when test="${not empty demandes}">
                                <div class="container liste-amis">
                                    <c:forEach items="${ demandes }" var="demande">
                                        <div class="card">

                                            <%-- Affichage du photo de profil de manière conditionnel --%>
                                            <c:choose>
                                                <%-- Si l'utilisateur n'a pas de photo de profil, on affiche l'avatar par défaut --%>
                                                <c:when test="${ empty demande.photo_profil }">
                                                    <img class="card-img-top" src="<c:out value="${ pageContext.request.contextPath }" />/assets/default.png" alt="" /> 
                                                </c:when>
                                                <c:otherwise>
                                                    <img class="card-img-top photo-ami" src="<c:out value="${ pageContext.request.contextPath }" />/<c:out value="${demande.photo_profil}" />" alt="" /> 
                                                </c:otherwise>
                                            </c:choose>

                                            <div class="card-body">
                                              <h4 class="card-title"> <c:out value="${ demande.nom }" /> <c:out value="${ demande.prenom }" /> </h4>

                                              <%-- Résidence --%>
                                              <p class="card-text"> 
                                                  <c:if test="${not empty demande.residence}">
                                                        <i class="fa fa-house"></i> 
                                                        <c:out value="${ demande.residence }" /> 
                                                  </c:if>
                                              </p>

                                              <%-- Info scolaire --%> 
                                              <p class="card-text"> 
                                                  <c:if test="${not empty demande.info_scolaire}">
                                                        <i class="fa fa-graduation-cap"></i>  
                                                        <c:out value="${ demande.info_scolaire }" />
                                                  </c:if>
                                              </p>

                                              <%-- Info professionnel --%>
                                              <p class="card-text"> 
                                                  <c:if test="${not empty demande.info_professionnel}">
                                                        <i class="fa fa-briefcase"></i> 
                                                        <c:out value="${ demande.info_professionnel }" /> 
                                                  </c:if>
                                              </p>
                                              
                                              <div class="d-flex justify-content-center">
                                                  <a type="button" href="${pageContext.request.contextPath}/membres/confirmation_demande?confirmation=1&id_demandeur=<c:out value="${demande.id_utilisateur}" />&id_receveur=<c:out value="${ sessionScope.utilisateurConnecte.id_utilisateur }" />" class="btn btn-primary btn-confirmer">
                                                        <i class="fa fa-user-check"></i> Accepter 
                                                    </a>
                                                  
                                                  <a type="button"  href="${pageContext.request.contextPath}/membres/confirmation_demande?confirmation=0&id_demandeur=<c:out value="${demande.id_utilisateur}" />&id_receveur=<c:out value="${ sessionScope.utilisateurConnecte.id_utilisateur }" />" class="btn btn-danger ms-2">
                                                        <i class="fa fa-user-xmark"></i> Refuser
                                                   </a>
                                              </div>
                                              
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="d-flex justify-content-center">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="150" height="150" viewBox="0 0 406.42221 421.66607" xmlns:xlink="http://www.w3.org/1999/xlink" role="img" artist="Katerina Limpitsouni" source="https://undraw.co/"><path d="m312.68163,369.42203l-122.48379,14.92695,14.10576-42.31728,106.29929-3.37977c5.07161-5.9909,13.18691-10.16395,22.5754-10.79824,16.42749-1.1098,30.48886,9.01159,31.40727,22.60666.91842,13.59519-11.65403,25.5156-28.08152,26.6254-9.3885.63416-17.99144-2.40975-23.82254-7.66383l.00013.00011Z" fill="#e29295" stroke-width="0"/><path d="m224.50691,199.98052l8.14982,112.46753,40.51059,27.48097-8.8161,31.73796-111.03939,13.07309,41.32813-177.20361,21.20416-12.16349c3.70325-2.12432,8.35423.34944,8.66279,4.60756Z" fill="#2f2e43" stroke-width="0"/><path d="m168.93798,57.82109c12.22707-30.54224,46.89852-45.38975,77.44089-33.16263,30.54249,12.22717,45.38987,46.89857,33.16275,77.44094-9.91627,24.77004-34.59483,39.21361-59.86064,37.26761l-38.9757,66.37345-36.31833-67.23503s17.77746-10.28339,30.861-24.66552c-10.95854-15.87784-14.01753-36.76595-6.30996-56.01882Z" fill="#e29295" stroke-width="0"/><path d="m208.94157,175.69689l-67.00236-72.29202s-26.4483-12.34254-35.2644,26.4483c0,0-46.84444,16.75059-63.53548,72.29202C26.4483,257.68662,0,421.66607,0,421.66607l202.7703-10.57932,20.96615-206.43593c1.19039-11.72079-4.5992-23.05118-14.79486-28.95393h-.00002Z" fill="#2f2e43" stroke-width="0"/><path d="m118.13574,130.73478s57.38816,38.79084,59.55043,71.41041" fill="none" stroke="#e6e6e6" stroke-miterlimit="10"/><path d="m406.42221,302.64872s-.49694-.33935-8.8161-22.92186l-81.22052,54.63879,24.79748,21.17967,65.23914-52.8966Z" fill="#6c63ff" stroke-width="0"/><path d="m304.97705,374.11956l-122.48379,14.92695,14.10576-42.31728,106.29929-3.37977c5.07161-5.9909,13.18691-10.16395,22.5754-10.79824,16.42749-1.1098,30.48886,9.01159,31.40727,22.60666.91842,13.59519-11.65403,25.5156-28.08152,26.6254-9.3885.63416-17.99144-2.40975-23.82254-7.66383l.00013.00011Z" fill="#e29295" stroke-width="0"/><path d="m153.40009,317.63565v-105.96022s-26.14611-90.42357-93.29999-44.24666c0,0,19.24475,217.898,52.74593,227.25133,33.50118,9.35333,81.10812-4.75243,81.10812-4.75243l16.25124-52.04598-56.8053-20.24604Z" fill="#2f2e43" stroke-width="0"/><path d="m60.10051,167.42905s19.24439,217.89754,52.74557,227.25118c33.50118,9.35364,81.10812-4.75212,81.10812-4.75212" fill="none" stroke="#e6e6e6" stroke-miterlimit="10"/><polyline points="210.20517 337.88186 153.40014 317.63609 153.40014 211.67512" fill="none" stroke="#e6e6e6" stroke-miterlimit="10"/><path d="m172.93373,111.4779s6.68712-31.62177,25.04764-38.52073c18.31867-6.88323,9.87463,13.8538,9.87463,13.8538l9.52256,2.4263s8.2133-20.16574,26.69831-15.12637l.74397-28.56703s37.43816,28.77648,40.58835,25.33197c24.78703-27.10288-47.50423-96.97595-95.29857-60.61505-74.33594,56.5532-17.17691,101.21711-17.17691,101.21711Z" fill="#2f2e43" stroke-width="0"/></svg>
                                </div>
                                <p class="text-center">Aucun demande d'ami pour le moment.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </main>
                          
        <srcipt src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript"></srcipt>
        <srcipt src="${pageContext.request.contextPath}/js/pooper.min.js" type="text/javascript"></srcipt>
        <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    </body>
</html>
