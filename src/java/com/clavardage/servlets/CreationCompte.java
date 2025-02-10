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

public class CreationCompte extends HttpServlet
{
    @Override 
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        this.getServletContext().getRequestDispatcher("/WEB-INF/creer_compte.jsp").forward(request, response);
    }
    
    @Override 
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        UtilisateurDAO utilisateurDAO = new UtilisateurDAO();
        Utilisateur utilisateurBean = new Utilisateur();
        HttpSession session = request.getSession();
        
        utilisateurBean.setNom(request.getParameter("nom"));
        utilisateurBean.setPrenom(request.getParameter("prenom"));
        utilisateurBean.setDate_naissance(request.getParameter("date_naissance"));
        utilisateurBean.setEmail(request.getParameter("email"));
        utilisateurBean.setMot_passe(request.getParameter("mot_passe"));
         
        try 
        {
            utilisateurDAO.addUtilisateur(utilisateurBean);
            utilisateurBean.setId_utilisateur(utilisateurDAO.getLastInsertIdUtilisateur());
            session.setAttribute("utilisateurConnecte", utilisateurBean);
            //this.getServletContext().getRequestDispatcher("/membres/information_profil").forward(request, response);
            response.sendRedirect( request.getContextPath() +  "/membres/information_profil" );
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
