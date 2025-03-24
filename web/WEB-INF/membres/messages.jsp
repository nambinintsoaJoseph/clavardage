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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/messages.css" />
    </head>
    <body>
        <header>
            <div class="container-fluid row entete">
                <div class="col d-flex justify-content-start p-3">
                    <div class="text-light ms-3"> <i class="fa fa-comments"></i> Clavardage</div>
                </div>
                <div class="col d-flex justify-content-end p-2">
                    <div class="">
                        <a href="${pageContext.request.contextPath}/membres/deconnexion" class="btn text-light ms-3"><i class="fa fa-right-from-bracket"></i> Deconnexion</a>
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
                                <a class="nav-link active" aria-current="page" href="#"> <i class="fa fa-envelope"></i> Messages</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/membres/profil"> <i class="fa fa-user"></i> Profil</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link"> <i class="fa fa-newspaper"></i> Notifications </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/membres/ami"> <i class="fa fa-users"></i> Ami(e)s </a>
                            </li>
                        </ul>
                        
                        <form class="d-flex" method="POST" action="${pageContext.request.contextPath}/membres/recherche_personne">
                          <input name="nom" class="form-control me-2" type="search" placeholder="Trouver une personne" aria-label="Search">
                          <button class="btn btn-outline-success" type="submit"> <i class="fa fa-search"></i></button>
                        </form>
                    </div>
                </div>
            </nav>
            
            <div class="container">
                <div class="d-flex justify-content-center mt-2">
                    <button type="button" class="btn btn-primary btn-creer-conversation" data-bs-toggle="modal" data-bs-target="#creerConversation"> <i class="fa fa-comment-medical"></i> Créer une conversation</button>
                </div>
            </div>
            
            <!-- Fenêtre modal pour la création d'un conversation -->
            <div class="modal fade" id="creerConversation">
                <div class="modal-dialog">
                  <div class="modal-content">

                    <div class="modal-header">
                      <h4 class="modal-title">Création d'une conversation</h4>
                      <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">
                        <form>
                            <input type="text" placeholder="Titre de la conversation" class="form-control" />
                            
                            <div class="d-flex justify-content-end mt-2">
                                <button type="submit" class="btn btn-primar btn-creer-conversation text-light">
                                    <i class="fa fa-comment-medical"></i> Créer la conversation
                                </button>
                            </div>
                            
                        </form>
                    </div>
                  </div>
                </div>
            </div>
            
            <div class="container mt-2 container-conversation">
                <c:forEach items="${ conversations}" var="conversation">
                    <div class="row conversation">
                        <div class="col-2 col-md-2 mt-2">
                            <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" viewBox="0 0 561 493" xmlns:xlink="http://www.w3.org/1999/xlink" role="img" artist="Katerina Limpitsouni" source="https://undraw.co/"><path d="M876.03027,689.45c-.98047,1.37-1.97021,2.73-2.95019,4.08A16.82838,16.82838,0,0,1,863.5,696.5h-527a16.90383,16.90383,0,0,1-9.21-2.72c-.91016-1.2-1.81006-2.41-2.72022-3.62006l.91016-.5L592.27,541.78a16.01919,16.01919,0,0,1,15.47021-.02L875.12988,688.95Z" transform="translate(-319.5 -203.5)" fill="#6c63ff"/><path d="M863.5,378.5,632.28169,244.96964a64.023,64.023,0,0,0-63.98147-.03153L336.5,378.5a17.0241,17.0241,0,0,0-17,17v284a17.01984,17.01984,0,0,0,17,17h527a17.02879,17.02879,0,0,0,17-17v-284A17.02408,17.02408,0,0,0,863.5,378.5Zm15,301a15.03649,15.03649,0,0,1-15,15h-527a15.02706,15.02706,0,0,1-15-15v-284a15.01828,15.01828,0,0,1,15-15L568.30022,246.93811a64.023,64.023,0,0,1,63.98147.03153L863.5,380.5a15.01828,15.01828,0,0,1,15,15Z" transform="translate(-319.5 -203.5)" fill="#3f3d56"/><path d="M600.2998,539.18018a15.36345,15.36345,0,0,1-5.116-.8584l-.30249-.10694-.06128-.67236c-.18848.09277-.37866.18164-.56909.26563l-.20118.08837-.20141-.08886c-.42139-.18506-.83985-.39453-1.24365-.62207L408.5,433.73242V222.5A18.5208,18.5208,0,0,1,427,204H773a18.5208,18.5208,0,0,1,18.5,18.5V434.00244l-.25488.14356-183.25,103.04A15.75694,15.75694,0,0,1,600.2998,539.18018Z" transform="translate(-319.5 -203.5)" fill="#fff"/><path d="M600.2998,539.68018a15.85649,15.85649,0,0,1-5.282-.88672l-.60547-.21338-.02588-.28565-.33691.14795-.40234-.17676c-.43653-.19189-.86963-.40869-1.28784-.64453L408,434.02539V222.5a19.02154,19.02154,0,0,1,19-19H773a19.02162,19.02162,0,0,1,19,19V434.29492L608.24,537.62158A16.2527,16.2527,0,0,1,600.2998,539.68018Zm-4.01342-2.57666a14.49247,14.49247,0,0,0,10.97436-1.22559L790,433.125V222.5a17.01917,17.01917,0,0,0-17-17H427a17.01909,17.01909,0,0,0-17,17V432.85449l11.98962,6.7334,171.35047,96.29053q.34973.197.71.3706.36035-.17358.70923-.37011l1.34668-.75879Z" transform="translate(-319.5 -203.5)" fill="#3f3d56"/><path d="M876.06982,385.88,803.5,426.68,791,433.71,607.75,536.75a15.24213,15.24213,0,0,1-7.4502,1.93,14.91079,14.91079,0,0,1-4.9497-.83,12.05366,12.05366,0,0,1-1.3003-.5q-.61449-.27-1.1997-.6L421.5,440.46,409,433.44l-84.91992-47.72a1.011,1.011,0,0,1-.37988-1.37.99933.99933,0,0,1,1.35986-.38L409,431.14l12.5,7.02L593.83008,535a13.07441,13.07441,0,0,0,1.77978.83c.26026.1.53028.19.8003.27A13.26424,13.26424,0,0,0,606.77,535L791,431.42l12.5-7.03,71.58984-40.25a.99849.99849,0,1,1,.98,1.74Z" transform="translate(-319.5 -203.5)" fill="#3f3d56"/><path d="M483.5748,269.5h-28a8,8,0,0,1,0-16h28a8,8,0,0,1,0,16Z" transform="translate(-319.5 -203.5)" fill="#6c63ff"/><path d="M516.5748,296.5h-61a8,8,0,0,1,0-16h61a8,8,0,0,1,0,16Z" transform="translate(-319.5 -203.5)" fill="#e6e6e6"/><path d="M687,368.5H514a8,8,0,0,1,0-16H687a8,8,0,0,1,0,16Z" transform="translate(-319.5 -203.5)" fill="#6c63ff"/><path d="M703,399.5H497a8,8,0,0,1,0-16H703a8,8,0,0,1,0,16Z" transform="translate(-319.5 -203.5)" fill="#e6e6e6"/><path d="M703,429.5H497a8,8,0,0,1,0-16H703a8,8,0,0,1,0,16Z" transform="translate(-319.5 -203.5)" fill="#e6e6e6"/></svg>
                        </div>
                        
                        <div class="col-8 mt-3 info-conversation">
                            <p> <c:out value="${conversation.titre}" /> </p>
                            <p>
                                <fmt:parseDate value="${conversation.date_creation}" pattern="yyyy-MM-dd HH:mm:ss" var="date_creation" />                  
                                
                                
                                Crée le : <fmt:formatDate value="${date_creation}" pattern="dd/MM/yyyy à HH:mm:ss" />
                           
                            </p>
                        </div>
                                
                        <div class="col-2 col-md-2 mt-4">
                            <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#supprimerConversation<c:out value="${conversation.id_conversation}" />">
                                <i class="fa fa-trash"></i> <span class="text-btn">Supprimer</span>
                            </button>
                        </div>
                    </div>
                                
                    <!-- Modal pour la confirmation de suppression du conversation --> 
                    <div class="modal" id="supprimerConversation<c:out value="${conversation.id_conversation}" />">
                        <div class="modal-dialog">
                          <div class="modal-content">

                            <div class="modal-header">
                              <h4 class="modal-title">Confirmation du suppression</h4>
                              <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>

                           
                            <div class="modal-body">
                                Êtes-vous sûr de vouloir supprimer cette conversation ? Vous allez perdre tous les messages appartenant à cette conversation. Cette action est irréversible.
                            </div>

                            
                            <div class="modal-footer">
                                <button class="btn btn-danger"> <i class="fa fa-trash"></i> Oui</button>
                                <button type="button" class="btn btn-success" data-bs-dismiss="modal"> <i class="fa fa-xmark"></i> Non</button>
                            </div>

                          </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
                           
        </main>
                
        <srcipt src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript"></srcipt>
        <srcipt src="${pageContext.request.contextPath}/js/pooper.min.js" type="text/javascript"></srcipt>
        <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    </body>
</html>
