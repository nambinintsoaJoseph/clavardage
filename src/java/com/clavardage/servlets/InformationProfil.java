package com.clavardage.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class InformationProfil extends HttpServlet
{
    @Override 
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        this.getServletContext().getRequestDispatcher("/WEB-INF/membres/information_profil.jsp").forward(request, response);
    }
    
    
}
