/**
 * Deconnexion.java
 * 
 * Permet d'invalider le session d'un utilisateur au moment de sa déconnexion. 
 * 
 */

package com.clavardage.servlets;

import com.clavardage.beans.Utilisateur;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Deconnexion extends HttpServlet
{
    @Override 
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        HttpSession session = request.getSession(); 
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateurConnecte"); 
        if(utilisateur == null) 
        {
            response.sendRedirect(request.getContextPath() + "/seconnecter");
            return; 
        }
        else 
        {
            session.invalidate(); 
            response.sendRedirect(request.getContextPath() + "/");
        }
    }
}
