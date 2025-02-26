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

public class ModificationProfil extends HttpServlet
{
    @Override 
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        request.setCharacterEncoding("UTF-8");
        UtilisateurDAO utilisateurDAO = new UtilisateurDAO(); 
        
        HttpSession session = request.getSession(); 
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateurConnecte");
        if (utilisateur == null) {
            response.sendRedirect(request.getContextPath() + "/connexion");
            return;
        }
        
        String date_naissance = request.getParameter("date_naissance"); 
        String residence = request.getParameter("residence"); 
        String info_scolaire = request.getParameter("info_scolaire"); 
        String info_professionnel = request.getParameter("info_professionnel"); 
        String email = request.getParameter("email"); 
     
        if(date_naissance != null && !date_naissance.isEmpty()) 
        {
            utilisateur.setDate_naissance(date_naissance);
        }
        
        if(residence != null && !residence.isEmpty()) 
        {
            utilisateur.setResidence(residence);
        }
        
        if(info_scolaire != null && !info_scolaire.isEmpty())
        {
            utilisateur.setInfo_scolaire(info_scolaire);
        }
            
        if(info_professionnel != null && !info_professionnel.isEmpty()) 
        {
            utilisateur.setInfo_professionnel(info_professionnel);
        }
        
        if(email != null && !email.isEmpty()) 
        {
            utilisateur.setEmail(email);
        }
        
        try 
        {
            utilisateurDAO.updateUtilisateur(utilisateur);
            response.sendRedirect(request.getContextPath() + "/membres/profil");
        } catch (ClassNotFoundException | SQLException ex) 
        {
            ex.printStackTrace();
        }
        
    }
}
