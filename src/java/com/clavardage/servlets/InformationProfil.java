package com.clavardage.servlets;

import com.clavardage.beans.Utilisateur;
import com.clavardage.dao.UtilisateurDAO;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;

public class InformationProfil extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/membres/information_profil.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateurConnecte");
        if (utilisateur == null) {
            response.sendRedirect(request.getContextPath() + "/connexion");
            return;
        }

        // Récupération des paramètres du formulaire
        String residence = request.getParameter("residence");
        String infoScolaire = request.getParameter("info_scolaire");
        String infoProfessionnel = request.getParameter("info_professionnel");

        // Gestion de l'upload de la photo de profil
        String photoProfilPath = handleFileUpload(request.getPart("photo_profil"), getServletContext().getRealPath(""));

        // Mise à jour des informations de l'utilisateur
        utilisateur.setResidence(residence);
        utilisateur.setInfo_scolaire(infoScolaire);
        utilisateur.setInfo_professionnel(infoProfessionnel);
        utilisateur.setPhoto_profil(photoProfilPath);

        try {
            System.out.println("Affichage de l'id avant la modification : " + utilisateur.getId_utilisateur());
            new UtilisateurDAO().updateUtilisateur(utilisateur);
            response.sendRedirect(request.getContextPath() + "/membres/profil");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Gère l'upload du fichier et retourne le chemin de stockage relatif.
     */
    private String handleFileUpload(Part filePart, String applicationPath) throws IOException {
        if (filePart == null || filePart.getSubmittedFileName().isEmpty()) {
            return null;
        }

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = applicationPath + File.separator + UPLOAD_DIR;

        // Création du dossier si inexistant
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists() && !uploadDir.mkdirs()) {
            System.err.println("Erreur : Impossible de créer le dossier d'upload.");
            return null;
        }

        // Sauvegarde du fichier sur le serveur
        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        System.out.println("Photo enregistrée : " + filePath);

        return UPLOAD_DIR + "/" + fileName; // Retourne le chemin relatif à stocker en base
    }
}