package com.clavardage.servlets;

import com.clavardage.beans.Utilisateur;
import com.clavardage.dao.UtilisateurDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SeConnecter extends HttpServlet
{
    @Override 
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        this.getServletContext().getRequestDispatcher("/WEB-INF/seconnecter.jsp").forward(request, response);
    }
    
    @Override 
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        String email = request.getParameter("email"); 
        HttpSession session = request.getSession(); 
        String mot_passe = request.getParameter("mot_passe"); 
        UtilisateurDAO utilisateurDAO = new UtilisateurDAO(); 
        Utilisateur utilisateur = new Utilisateur(); 
        
        try 
        {
            utilisateur = utilisateurDAO.authentificateUtilisateur(email, mot_passe);
            if(utilisateur != null)
            {
                session.setAttribute("utilisateurConnecte", utilisateur);
                response.sendRedirect(request.getContextPath() + "/membres/profil");
            }
            else 
            {
                // Permettra à la vue d'afficher un petit message d'erreur 
                request.setAttribute("erreurAuthentification", true);
                
                this.getServletContext().getRequestDispatcher("/WEB-INF/seconnecter.jsp").forward(request, response);
            }
        } 
        catch (ClassNotFoundException ex) 
        {
            ex.printStackTrace();
        } 
        catch (SQLException ex) 
        {
            ex.printStackTrace();
        }
    }
}
