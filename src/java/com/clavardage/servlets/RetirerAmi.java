/**
 * RetirerAmi.java
 * 
 * Rôle : Servlet chargée de retirer un ami d'un utilisateur
 * 
 */
package com.clavardage.servlets;

import com.clavardage.beans.Utilisateur;
import com.clavardage.dao.AmiDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class RetirerAmi extends HttpServlet 
{
    private final String VUE_REDIRECTION = "/WEB-INF/membres/ami.jsp"; 
    
    @Override 
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        HttpSession session = request.getSession();
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateurConnecte");
        AmiDAO amiDAO = new AmiDAO();
        
        int id_utilisateur = utilisateur.getId_utilisateur(); 
        int id_ami_utilisateur = Integer.parseInt(request.getParameter("id_ami_utilisateur"));
        
        try 
        {
            amiDAO.retirer(id_utilisateur, id_ami_utilisateur);
        } catch (ClassNotFoundException | SQLException ex) 
        {
            ex.printStackTrace();
        } 
        
        this.getServletContext().getRequestDispatcher(VUE_REDIRECTION).forward(request, response);
    }
}
