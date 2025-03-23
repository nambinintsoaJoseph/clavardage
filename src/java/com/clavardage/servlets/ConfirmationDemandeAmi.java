/**
 * ConfirmationDemandeAmi.java
 * 
 * Rôle : Servlet chargée de gérer le choix de l'utilisateur pour une demande d'ami
 */
package com.clavardage.servlets;

import com.clavardage.dao.AmiDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ConfirmationDemandeAmi extends HttpServlet
{
    @Override 
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        AmiDAO amiDAO = new AmiDAO(); 
        int confirmation = Integer.parseInt(request.getParameter("confirmation"));
        int id_demandeur = Integer.parseInt(request.getParameter("id_demandeur"));
        int id_receveur = Integer.parseInt(request.getParameter("id_receveur"));
        
        if(confirmation == 1)
        {
            try 
            {
                amiDAO.accepterDemande(id_demandeur, id_receveur);
            } 
            catch(ClassNotFoundException | SQLException ex) 
            {
                ex.printStackTrace();
            }
        }
        else
        {
            try 
            {
                amiDAO.supprimerDemande(id_demandeur, id_receveur);
            }
            catch(ClassNotFoundException | SQLException ex)
            {
                ex.printStackTrace();
            }
        }
        
        this.getServletContext().getRequestDispatcher("/membres/ami").forward(request, response);
    }
}
