/**
 * ListeConversation.java
 * 
 * Rôle : Servlet chargé d'afficher la liste de conversation d'un utilisateur
 */

package com.clavardage.servlets; 

import com.clavardage.beans.Conversation;
import com.clavardage.beans.Utilisateur;
import com.clavardage.dao.ConversationDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ListeConversation extends HttpServlet 
{
    @Override 
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        HttpSession session = request.getSession();
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateurConnecte");
        List<Conversation> conversations = new ArrayList<Conversation>(); 
        ConversationDAO conversationDAO = new ConversationDAO(); 
        
        try 
        {
            conversations = conversationDAO.getConversationUtilisateur(utilisateur.getId_utilisateur());
            request.setAttribute("conversations", conversations);
            this.getServletContext().getRequestDispatcher("/WEB-INF/membres/messages.jsp").forward(request, response);
        } 
        catch(ClassNotFoundException | SQLException ex) 
        {
            ex.printStackTrace();
        }
    }
}