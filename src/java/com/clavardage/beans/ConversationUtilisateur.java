package com.clavardage.beans;

import java.io.Serializable;

public class ConversationUtilisateur implements Serializable
{
    private int id_conversation_utilisateur; 
    private int id_conversation; 
    private int id_utilisateur; 

    public int getId_conversation_utilisateur() 
    {
        return id_conversation_utilisateur;
    }

    public void setId_conversation_utilisateur(int id_conversation_utilisateur) 
    {
        if(id_conversation_utilisateur <= 0) 
        {
            throw new IllegalArgumentException("id_conversation_utilisateur invalide.");
        }
        this.id_conversation_utilisateur = id_conversation_utilisateur;
    }

    public int getId_conversation() 
    {
        return id_conversation;
    }

    public void setId_conversation(int id_conversation) 
    {
        if(id_conversation <= 0) 
        {
            throw new IllegalArgumentException("id_conversation ivalide."); 
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
    
}
