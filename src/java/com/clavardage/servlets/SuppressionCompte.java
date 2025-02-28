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

public class SuppressionCompte extends HttpServlet
{
    @Override 
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        UtilisateurDAO utilisateurDAO = new UtilisateurDAO(); 
        String mot_passe = request.getParameter("mot_passe"); 
        
        HttpSession session = request.getSession(); 
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateurConnecte"); 
        if(utilisateur == null) 
        {
            response.sendRedirect(request.getContextPath() + "/");
            return; 
        }
        
        try 
        {
            if(utilisateurDAO.authentificateUtilisateur(utilisateur.getEmail(), mot_passe))
            {
                new UtilisateurDAO().deleteUtilisateur(utilisateur);
                session.invalidate();
                response.sendRedirect(request.getContextPath() + "/seconnecter");
            }
            else
            {
                request.setAttribute("error", "Mot de passe incorrect. Suppression annulée");
                request.getRequestDispatcher("/membres/profil").forward(request, response);
            }    
        } catch (ClassNotFoundException | SQLException ex) 
        {
            ex.printStackTrace();
        } 
    }
}
