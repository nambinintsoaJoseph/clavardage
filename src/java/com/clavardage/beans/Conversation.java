package com.clavardage.beans;

import java.io.Serializable;

public class Conversation implements Serializable
{
    private int id_conversation;
    private String titre; 
    private String date_creation; 
    
    public Conversation() {} 

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

    public String getTitre() 
    {
        return titre;
    }

    public void setTitre(String titre)
    {
        this.titre = titre;
    }

    public String getDate_creation()
    {
        return date_creation;
    }

    public void setDate_creation(String date_creation)
    {
        String regexDate_creation = "^(19|20)\\d\\d-(0[1-9]|1[0-2])-(0[1-9]|[12]\\d|3[01])\\s(0\\d|1\\d|2[0-3]):([0-5]\\d):([0-5]\\d)$";
        if(date_creation == null || !date_creation.matches(regexDate_creation)) 
        {
            throw new IllegalArgumentException("date_creation invalide."); 
        }
        this.date_creation = date_creation;
    }
  
}
