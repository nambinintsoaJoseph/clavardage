package com.clavardage.servlets;

import com.clavardage.beans.Utilisateur;
import com.clavardage.dao.UtilisateurDAO;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

public class ModificationPhoto extends HttpServlet 
{

    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateurConnecte");

        if (utilisateur == null) {
            response.sendRedirect(request.getContextPath() + "/connexion");
            return;
        }

        Part filePart = request.getPart("photo_profil");

        String photoProfilPath = handleFileUpload(filePart, getServletContext().getRealPath(""));

        if (photoProfilPath != null) 
        {
            utilisateur.setPhoto_profil(photoProfilPath);

            try 
            {
                new UtilisateurDAO().updateUtilisateur(utilisateur);
                response.sendRedirect(request.getContextPath() + "/membres/profil");
            } 
            catch (Exception e) 
            {
                e.printStackTrace();
            }
        } 
        else 
        {
            System.out.println("Aucune photo téléchargée.");
        }
    }

    /**
     * Gérer l'upload de la photo et renvoyer le chemin relatif de la photo.
     */
    private String handleFileUpload(Part filePart, String applicationPath) throws IOException 
    {
        if (filePart == null || filePart.getSubmittedFileName().isEmpty()) 
        {
            return null; // Si aucun fichier n'est sélectionné, retourner null
        }

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = applicationPath + File.separator + UPLOAD_DIR;

        // Créer le dossier de destination s'il n'existe pas
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists() && !uploadDir.mkdirs())
        {
            System.err.println("Erreur : Impossible de créer le dossier d'upload.");
            return null;
        }

        // Sauvegarder le fichier sur le serveur
        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        // Retourner le chemin relatif pour stocker dans la base de données
        return UPLOAD_DIR + "/" + fileName;
    }
}
