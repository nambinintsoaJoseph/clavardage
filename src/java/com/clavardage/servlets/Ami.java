/**
 * RecherchePersonne.java
 * 
 * Rôle : Servlet chargée de récuperer les ami(e)s d'un utilisateur.
 * 
 */
package com.clavardage.servlets;

import com.clavardage.beans.Utilisateur;
import com.clavardage.dao.AmiDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Ami extends HttpServlet
{
    private final String VUE = "/WEB-INF/membres/ami.jsp"; 
    
    @Override 
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        HttpSession session = request.getSession();
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateurConnecte");
        
        List<Utilisateur> amis = new ArrayList<Utilisateur>(); 
        AmiDAO amiDAO = new AmiDAO(); 
        
        try 
        {
            amis = amiDAO.getAmis(utilisateur.getId_utilisateur());
            System.out.println(amis.size()); 
            request.setAttribute("amis", amis);
            this.getServletContext().getRequestDispatcher(VUE).forward(request, response);
        } catch (ClassNotFoundException | SQLException ex) 
        {
            ex.printStackTrace();
        } 
    }
}
