package com.clavardage.servlets;

import com.clavardage.beans.Utilisateur;
import com.clavardage.dao.UtilisateurDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CreationCompteServlet extends HttpServlet
{
    @Override 
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        UtilisateurDAO utilisateurDAO = new UtilisateurDAO();
        Utilisateur utilisateurBean = new Utilisateur();
        
        utilisateurBean.setNom(request.getParameter("nom"));
        utilisateurBean.setPrenom(request.getParameter("prenom"));
        utilisateurBean.setDate_naissance(request.getParameter("date_naissance"));
        utilisateurBean.setEmail(request.getParameter("email"));
        utilisateurBean.setMot_passe(request.getParameter("mot_passe"));
         
        try 
        {
            utilisateurDAO.ajouter(utilisateurBean);
            this.getServletContext().getRequestDispatcher("/WEB-INF/info_profil.jsp").forward(request, response);
        } 
        catch (ClassNotFoundException ex) 
        {
            ex.printStackTrace();
        } 
        catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}
