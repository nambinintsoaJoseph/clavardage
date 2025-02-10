/**
 * EspaceMembreFilter.java 
 * 
 * Rôle : filtre permettant de restreindre l'accès aux VUES 
 * pour les utilisateurs non connecté.
 */

package com.clavardage.filters;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class EspaceMembreFilter implements Filter 
{
    @Override
    public void init(FilterConfig config) throws ServletException {}
    
    @Override 
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException 
    {
        // Cast des objets request et response 
        HttpServletRequest req = (HttpServletRequest) request; 
        HttpServletResponse resp = (HttpServletResponse) response; 
        
        // Récuperation de la session
        HttpSession session = req.getSession(); 
        
        if(session.getAttribute("utilisateurConnecte") == null)
        {
            resp.sendRedirect(req.getContextPath() + "/seconnecter");
        }
        else 
        {
            chain.doFilter(req, resp);
        }
    }
    
    @Override 
    public void destroy() {}
}
