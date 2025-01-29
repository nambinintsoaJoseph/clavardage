/*
    Jdbc.java :
    Permet de fournir une méthode pour récuperer la connexion à la base de données. 
*/

package com.clavardage.jdbc;
import java.sql.Connection;
import java.sql.DriverManager; 
import java.sql.SQLException; 

public class Jdbc 
{
    public Connection getConnection() throws ClassNotFoundException 
    {
        String url = "jdbc:mysql://localhost:3306/clavardage"; 
        String utilisateur = "root"; 
        String motDePasse = ""; 
        Connection connexion = null; 
        
        try
        { 
            // Chargement du pilote 
            Class.forName("com.mysql.jdbc.Driver"); 
            
            // Ouverture d'une connexion
            connexion = DriverManager.getConnection(url, utilisateur, motDePasse);
            System.out.println("La connexion a la base de donnee a fonctionne"); 
        }
        catch(SQLException e)
        {
            System.out.println("Erreur de la connexion a la base de donnees : " + e.getMessage()); 
        }
        
        return connexion;
    }
}
