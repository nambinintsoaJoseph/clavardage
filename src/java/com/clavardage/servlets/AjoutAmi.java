package com.clavardage.servlets;

import com.clavardage.beans.Utilisateur;
import com.clavardage.dao.AmiDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AjoutAmi extends HttpServlet
{
    @Override 
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        HttpSession session = request.getSession(); 
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateurConnecte");
        int id_utilisateur = utilisateur.getId_utilisateur(); 
        int id_autre_utilisateur = Integer.parseInt(request.getParameter("id_autre_utilisateur")); 
        AmiDAO amiDAO = new AmiDAO(); 
        
        try 
        {
            amiDAO.ajouter(id_utilisateur, id_autre_utilisateur);
            response.sendRedirect(request.getContextPath() + "/membres/ami");
        } catch (ClassNotFoundException | SQLException ex) 
        {
            ex.printStackTrace();
        } 
    }
}
