package com.clavardage.beans;

import java.io.Serializable;

public class Ami implements Serializable
{
    private int id_ami; 
    private int id_demandeur; 
    private int id_receveur; 
    private String status; 
    private String date_demande; 
    
    public Ami() {} 

    public int getId_ami() 
    {
        return id_ami;
    }

    public void setId_ami(int id_ami) 
    {
        if(id_ami <= 0) 
        {
            throw new IllegalArgumentException("id_ami invalide");
        }
        this.id_ami = id_ami;
    }

    public int getId_demandeur() 
    {
        return id_demandeur;
    }

    public void setId_demandeur(int id_demandeur) 
    {
        if(id_demandeur <= 0) 
        {
            throw new IllegalArgumentException("id_demandeur invalide");
        }
        this.id_demandeur = id_demandeur;
    }

    public int getId_receveur() 
    {
        return id_receveur;
    }

    public void setId_receveur(int id_receveur)
    {
        if(id_receveur <= 0) 
        {
            throw new IllegalArgumentException("id_receveur invalide");
        }
        this.id_receveur = id_receveur;
    }

    public String getStatus() 
    {
        return status;
    }

    public void setStatus(String status)
    {
        boolean valeurStatusAccepte = status.equals("attente") || status.equals("accepte") || status.equals("rejete");
        if(status == null || !valeurStatusAccepte) 
        {
            throw new IllegalArgumentException("status invalide"); 
        }
        this.status = status;
    }

    public String getDate_demande() 
    {
        return date_demande;
    }

    public void setDate_demande(String date_demande) 
    {
        String regexDateDemande = "^(19|20)\\d\\d-(0[1-9]|1[0-2])-(0[1-9]|[12]\\d|3[01])$";
        if(date_demande == null || !date_demande.matches(regexDateDemande))
        {
            throw new IllegalArgumentException("date_demande invalide"); 
        }
        this.date_demande = date_demande;
    }
     
}
