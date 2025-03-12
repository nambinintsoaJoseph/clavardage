/**
 * RecherchePersonne.java
 * 
 * Rôle : Servlet chargée de traiter les requêtes de recherche d'une personne par son nom.
 * 
 */
package com.clavardage.servlets;

import com.clavardage.beans.Utilisateur;
import com.clavardage.dao.UtilisateurDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RecherchePersonne extends HttpServlet
{
    private final String VUE = "/WEB-INF/membres/resultat_recherche_personne.jsp";
    
    @Override 
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        String nom = request.getParameter("nom"); 
        UtilisateurDAO utilisateurDAO = new UtilisateurDAO(); 
        List<Utilisateur> utilisateurs = new ArrayList<Utilisateur>(); // Pour stocker le résultat 
        
        try 
        {
            utilisateurs = utilisateurDAO.findUtilisateurByName(nom);
            
            if(utilisateurs.size() > 0) 
            {
                request.setAttribute("utilisateursTrouve", utilisateurs);
            }
            
            
            this.getServletContext().getRequestDispatcher(VUE).forward(request, response);
        } catch (ClassNotFoundException | SQLException ex) 
        {
            ex.printStackTrace();
        } 
    }
}
