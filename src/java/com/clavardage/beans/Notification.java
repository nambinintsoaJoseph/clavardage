package com.clavardage.beans;

import java.io.Serializable;

public class Notification implements Serializable
{
    private int id_notification;
    private int id_utilisateur; 
    private String contenu; 
    
    public Notification() {}

    public int getId_notification() 
    {
        return id_notification;
    }

    public void setId_notification(int id_notification) 
    {
        if(id_notification <= 0) 
        {
            throw new IllegalArgumentException("id_noficiation invalide"); 
        }
        this.id_notification = id_notification;
    }

    public int getId_utilisateur() 
    {
        return id_utilisateur;
    }

    public void setId_utilisateur(int id_utilisateur) 
    {
        if(id_utilisateur <= 0) 
        {
            throw new IllegalArgumentException("id_utilisateur invalide"); 
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
      
}
