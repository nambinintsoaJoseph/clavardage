package com.clavardage.beans;

import java.io.Serializable;

public class Utilisateur implements Serializable
{
    private int id_utilisateur; 
    private String nom; 
    private String prenom; 
    private String date_naissance; 
    private String email; 
    private String mot_passe; 
    private String residence; 
    private String info_scolaire; 
    private String info_professionnel; 
    private String photo_profil; 
    
    public Utilisateur() {}
    
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

    public String getNom() 
    {
        return nom;
    }
    
    public void setNom(String nom) 
    {
        if(nom == null || !nom.matches("^[a-zA-Zàâäéèëêîïôùû]+$")) 
        {
            throw new IllegalArgumentException("Nom invalide.");
        }
        this.nom = nom;
    }

    public String getPrenom() 
    {
        return prenom;
    }
    
    public void setPrenom(String prenom) 
    {
        if(prenom == null || !prenom.matches("^[a-zA-Zàâäéèëêîïôùû]+$")) 
        {
            throw new IllegalArgumentException("Prenom invalide.");
        }
        this.prenom = prenom;
    }
    
    public String getDate_naissance() 
    {
        return date_naissance;
    }

    public void setDate_naissance(String date_naissance) 
    {
        String regexDateNaissance = "^(19|20)\\d\\d-(0[1-9]|1[0-2])-(0[1-9]|[12]\\d|3[01])$";
        if(date_naissance == null || !date_naissance.matches(regexDateNaissance))
        {
            throw new IllegalArgumentException("Date de naissance invalide");
        }
        this.date_naissance = date_naissance;
    }
    
    public String getEmail() 
    {
        return email;
    }
    
    public void setEmail(String email) 
    {
        String regexEmail = "^[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\\.[a-z]{2,}$";
        if(email == null || !email.matches(regexEmail)) 
        {
            throw new IllegalArgumentException("Adresse email invalide"); 
        }
        this.email = email;
    }

    public String getMot_passe() 
    {
        return mot_passe;
    }

    public void setMot_passe(String mot_passe) 
    {
        this.mot_passe = mot_passe;
    }
    
    public String getResidence() 
    {
        return residence;
    }
    
    public void setResidence(String residence) 
    {
        this.residence = residence;
    }

    public String getInfo_scolaire() 
    {
        return info_scolaire;
    }
    
    public void setInfo_scolaire(String info_scolaire) 
    {
        this.info_scolaire = info_scolaire;
    }

    public String getInfo_professionnel() 
    {
        return info_professionnel;
    }
    
    public void setInfo_professionnel(String info_professionnel) 
    {
        this.info_professionnel = info_professionnel;
    }

    public String getPhoto_profil() 
    {
        return photo_profil;
    }
    
    public void setPhoto_profil(String photo_profil) 
    {
        this.photo_profil = photo_profil;
    } 
    
}
