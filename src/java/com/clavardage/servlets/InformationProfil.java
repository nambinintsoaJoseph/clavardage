package com.clavardage.servlets;

import com.clavardage.beans.Utilisateur;
import com.clavardage.dao.UtilisateurDAO;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;


public class InformationProfil extends HttpServlet
{
    @Override 
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        this.getServletContext().getRequestDispatcher("/WEB-INF/membres/information_profil.jsp").forward(request, response);
    }
    
    @Override 
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        request.setCharacterEncoding("UTF-8");
        final String UPLOAD_DIR = "uploads";
        HttpSession session = request.getSession();
        UtilisateurDAO utilisateurDAO = new UtilisateurDAO();
        Utilisateur utilisateurBean = (Utilisateur) session.getAttribute("utilisateurConnecte");
        String residence = request.getParameter("residence"); 
        String info_scolaire = request.getParameter("info_scolaire"); 
        String info_professionnel = request.getParameter("info_professionnel");
        
        // Gérer l'upload du fichier 
        Part filePart = request.getPart("photo_profil"); // Récuperer le fichier 
        String nomFichier = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        String path_photo_profil = null;
        
        if(nomFichier != null && !nomFichier.isEmpty())
        {
            File uploadDir = new File(uploadPath);
            if(!uploadDir.exists()) uploadDir.mkdir(); // Créer le dossier s'il n'existe pas 

            String filePath = uploadPath + File.separator + nomFichier;
            filePart.write(filePath); // Enregistrer le fichier sur le disque 
            
            System.out.println("Le photo a ete enregistrer dans le serveur.");

            // Construire le chemin à stocker dans la base de données 
            path_photo_profil = UPLOAD_DIR + "/" + nomFichier;
        }
        
        utilisateurBean.setResidence(residence);
        utilisateurBean.setInfo_scolaire(info_scolaire);
        utilisateurBean.setInfo_professionnel(info_professionnel);
        utilisateurBean.setPhoto_profil(path_photo_profil);
        
        try 
        {
            utilisateurDAO.updateUtilisateur(utilisateurBean);
            response.sendRedirect( request.getContextPath() +  "/membres/profil" );
        } 
        catch (ClassNotFoundException ex) 
        {
            ex.printStackTrace();
        } catch (SQLException ex) 
        {
            ex.printStackTrace();
        }    
    }
}
