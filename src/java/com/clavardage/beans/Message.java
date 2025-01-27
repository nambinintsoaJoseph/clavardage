package com.clavardage.beans;

import java.io.Serializable;

public class Message implements Serializable
{
    private int id_message; 
    private int id_conversation; 
    private int id_utilisateur; 
    private String contenu; 
    private String date_envoi; 
    private boolean est_lu; 
    private String nom_fichier; 
    private String chemin_fichier; 
    private double taille_fichier;
    
    public Message() {}

    public int getId_message() 
    {
        return id_message;
    }

    public void setId_message(int id_message) 
    {
        if(id_message <= 0)
        {
            throw new IllegalArgumentException("id_message invalide."); 
        }
        this.id_message = id_message;
    }

    public int getId_conversation() 
    {
        return id_conversation;
    }

    public void setId_conversation(int id_conversation) 
    {
        if(id_conversation <= 0)
        {
            throw new IllegalArgumentException("id_conversation invalide.");
        }
        this.id_conversation = id_conversation;
    }

    public int getId_utilisateur() 
    {
        return id_utilisateur;
    }

    public void setId_utilisateur(int id_utilisateur) 
    {
        if(id_utilisateur <= 0)
        {
            throw new IllegalArgumentException("id_utilisateur invalide.");
        }
        this.id_utilisateur = id_utilisateur;
    }

    public String getContenu() 
    {
        return contenu;
    }

    public void setContenu(String contenu) 
    {
        this.contenu = contenu;
    }

    public String getDate_envoi() 
    {
        return date_envoi;
    }

    public void setDate_envoi(String date_envoi) 
    {
        String regexDateEnvoi = "^20\\d\\d-(0[1-9]|1[0-2])-(0[1-9]|[12]\\d|3[01]) (0[0-9]|1[0-9]|2[0-3]):([0-5]\\d):([0-5]\\d)$"; 
        if(date_envoi == null || !date_envoi.matches(regexDateEnvoi))
        {
            throw new IllegalArgumentException("date_envoi invalide"); 
        }
        this.date_envoi = date_envoi;
    }

    public boolean isEst_lu() 
    {
        return est_lu;
    }

    public void setEst_lu(boolean est_lu) 
    {
        this.est_lu = est_lu;
    }

    public String getNom_fichier() 
    {
        return nom_fichier;
    }

    public void setNom_fichier(String nom_fichier) 
    {
        if(nom_fichier == null)
        {
            throw new IllegalArgumentException("nom_fichier invalide."); 
        }

        // Supprimer tous les espaces blancs : 
        nom_fichier = nom_fichier.replaceAll("\\s+", "");
        
        // Supprimer les caractères spéciaux non désirés (qui n'est pas une lettre ou un chiffre, ou un point) :
        nom_fichier = nom_fichier.replaceAll("[^a-zA-Z0-9.]", ""); 
        
        // Convertir en minuscule : 
        nom_fichier = nom_fichier.toLowerCase();
        
        // Supprimer les espaces en début et fin de chaîne : 
        nom_fichier = nom_fichier.trim();
        
        this.nom_fichier = nom_fichier;
    }

    public String getChemin_fichier() 
    {
        return chemin_fichier;
    }

    public void setChemin_fichier(String chemin_fichier) 
    {
        this.chemin_fichier = chemin_fichier;
    }

    public double getTaille_fichier() 
    {
        return taille_fichier;
    }

    public void setTaille_fichier(double taille_fichier) 
    {
        this.taille_fichier = taille_fichier;
    }  
}
