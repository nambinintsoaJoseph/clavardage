package com.clavardage.dao;

import com.clavardage.beans.Utilisateur;
import com.clavardage.jdbc.Jdbc;
import java.sql.*;

public class UtilisateurDAO 
{
    public void ajouter(Utilisateur utilisateur) throws ClassNotFoundException, SQLException 
    {
        Jdbc jdbc = new Jdbc(); 
        String sql = "INSERT INTO utilisateur(nom, prenom, date_naissance, email, mot_passe) VALUES(?, ?, ?, ?, ?)";
        System.out.println(sql);
        
        try (Connection connection = jdbc.getConnection(); PreparedStatement stmt = connection.prepareStatement(sql))
        {
            stmt.setString(1, utilisateur.getNom());
            stmt.setString(2, utilisateur.getPrenom());
            stmt.setString(3, utilisateur.getDate_naissance());
            stmt.setString(4, utilisateur.getEmail());
            stmt.setString(5, utilisateur.getMot_passe());
     
            System.out.println(stmt.toString());
            stmt.executeUpdate();
        } 
        catch(ClassNotFoundException ex) 
        {
            ex.printStackTrace();
        }
        catch(SQLException ex) 
        {
            ex.printStackTrace();
        }
    }
}
