/**
 * UtilisateurDAO.java
 * 
 * Rôle : 
 * On trouve ici les opérations classique de stockage pour la table Utilisateur
 */

package com.clavardage.dao;

import com.clavardage.beans.Utilisateur;
import com.clavardage.jdbc.Jdbc;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UtilisateurDAO 
{
    /**
     * Permet d'ajouter un utilisateur
     * 
     * @param utilisateur bean java qui represente la table utilisateur du côté orienté objet. 
     * 
     * @throws ClassNotFoundException
     * @throws SQLException 
     */
    public void addUtilisateur(Utilisateur utilisateur) throws ClassNotFoundException, SQLException 
    {
        Jdbc jdbc = new Jdbc(); 
        String sql = "INSERT INTO utilisateur(nom, prenom, date_naissance, email, mot_passe) VALUES(?, ?, ?, ?, ?)";
        
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
    
    /**
     * Permet de modifier les informations d'un utilisateur
     * 
     * @param utilisateur bean java representant l'utilisateur à modifier
     * 
     * @throws ClassNotFoundException
     * @throws SQLException 
     */
    public void updateUtilisateur(Utilisateur utilisateur) throws ClassNotFoundException, SQLException 
    {
        Jdbc jdbc = new Jdbc(); 
        String sql = "UPDATE utilisateur SET nom = ?, prenom = ?, date_naissance = ?, "
                + "email = ?, mot_passe = ?, residence = ?, info_scolaire = ?, "
                + "info_professionnel = ?, photo_profil = ? WHERE id_utilisateur = ?";
        
        try (Connection connection = jdbc.getConnection(); PreparedStatement stmt = connection.prepareStatement(sql))
        {
            stmt.setString(1, utilisateur.getNom());
            stmt.setString(2, utilisateur.getPrenom());
            stmt.setString(3, utilisateur.getDate_naissance());
            stmt.setString(4, utilisateur.getEmail());
            stmt.setString(5, utilisateur.getMot_passe());
            stmt.setString(6, utilisateur.getResidence());
            stmt.setString(7, utilisateur.getInfo_scolaire());
            stmt.setString(8, utilisateur.getInfo_professionnel());
            stmt.setString(9, utilisateur.getPhoto_profil());
            stmt.setInt(10, utilisateur.getId_utilisateur());
            
            System.out.println(stmt);
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
    
    /**
     * Permet de supprimer un utilisateur 
     * @param utilisateur bean java representant l'utilisateur a supprimer
     * 
     * @throws ClassNotFoundException
     * @throws SQLException 
     */
    public void deleteUtilisateur(Utilisateur utilisateur) throws ClassNotFoundException, SQLException 
    {
        Jdbc jdbc = new Jdbc(); 
        String sql = "DELETE FROM utilisateur WHERE id_utilisateur = ?";
        
        try (Connection connection = jdbc.getConnection(); PreparedStatement stmt = connection.prepareStatement(sql))
        {
            stmt.setInt(1, utilisateur.getId_utilisateur());
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
    
    /**
     * Permet de récuperer les informations d'un utilisateur à partir de son id
     * 
     * @param idUtilisateur id de l'utilisateur 
     * @return Utilisateur obj | null : retourne un objet de la classe Utilisateur ou null.
     * 
     * @throws ClassNotFoundException
     * @throws SQLException 
     */
    public Utilisateur findUtilisateurById(int idUtilisateur) throws ClassNotFoundException, SQLException 
    {
        Jdbc jdbc = new Jdbc();
        Utilisateur utilisateur = new Utilisateur(); 
        String sql = "SELECT * FROM utilisateur WHERE id_utilisateur = ?";
        
        try (Connection connection = jdbc.getConnection(); PreparedStatement stmt = connection.prepareStatement(sql))
        {
            stmt.setInt(1, idUtilisateur);
            ResultSet utilisateurTrouve = stmt.executeQuery();
            
            if(utilisateurTrouve != null)
            {
                while(utilisateurTrouve.next())
                {
                    utilisateur.setNom(utilisateurTrouve.getString("nom"));
                    utilisateur.setPrenom(utilisateurTrouve.getString("prenom"));
                    utilisateur.setDate_naissance(utilisateurTrouve.getString("date_naissance"));
                    utilisateur.setEmail(utilisateurTrouve.getString("email"));
                    utilisateur.setResidence(utilisateurTrouve.getString("residence"));
                    utilisateur.setInfo_scolaire(utilisateurTrouve.getString("info_scolaire"));
                    utilisateur.setInfo_professionnel(utilisateurTrouve.getString("info_professionnel"));
                    utilisateur.setPhoto_profil(utilisateurTrouve.getString("photo_profil"));
                }
                return utilisateur;
            }
        } 
        catch(ClassNotFoundException ex) 
        {
            ex.printStackTrace();
        }
        catch(SQLException ex) 
        {
            ex.printStackTrace();
        }
        return null;
    }
    
    
    /**
     * Permet de trouver un utilisateur à partir de son nom ou son prenom
     * 
     * @param nomUtilisateur nom ou le prenom de l'utilisateur que l'on veut chercher 
     * 
     * @return List<Utilisateur> liste des utilisateurs trouvés
     * 
     * @throws ClassNotFoundException
     * @throws SQLException 
     */
    public List<Utilisateur> findUtilisateurByName(String nomUtilisateur) throws ClassNotFoundException, SQLException
    {
        Jdbc jdbc = new Jdbc();
        List<Utilisateur> utilisateurs = new ArrayList<Utilisateur>();
        String sql = "SELECT id_utilisateur, nom, prenom, residence, photo_profil "
                + "FROM utilisateur WHERE nom = ? OR prenom = ?";
        
        try (Connection connection = jdbc.getConnection(); PreparedStatement stmt = connection.prepareStatement(sql))
        {
            stmt.setString(1, nomUtilisateur);
            stmt.setString(2, nomUtilisateur);
            ResultSet utilisateursTrouve = stmt.executeQuery();
            
            while(utilisateursTrouve.next())
            {
                Utilisateur utilisateur = new Utilisateur();
                utilisateur.setId_utilisateur(utilisateursTrouve.getInt("id_utilisateur"));
                utilisateur.setNom(utilisateursTrouve.getString("nom"));
                utilisateur.setPrenom(utilisateursTrouve.getString("prenom"));
                utilisateur.setResidence(utilisateursTrouve.getString("residence"));
                utilisateur.setPhoto_profil(utilisateursTrouve.getString("photo_profil"));
                
                // On ajoute l'utilisateur dans la liste
                utilisateurs.add(utilisateur);
            }
            return utilisateurs;
        }
        catch(ClassNotFoundException ex) 
        {
            ex.printStackTrace();
        }
        catch(SQLException ex) 
        {
            ex.printStackTrace();
        }
        return null;
    }
    
    /**
     * Permet d'authentifier un utilisateur.
     * 
     * @param email email de l'utilisateur
     * @param mot_passe mot de passe de l'utilisateur.
     * 
     * @return true si les informations d'authentification sont corretes, false sinon.
     */
    public boolean authentificateUtilisateur(String email, String mot_passe) throws ClassNotFoundException, SQLException
    {
        Jdbc jdbc = new Jdbc();
        String sql = "SELECT id_utilisateur, email, mot_passe FROM utilisateur "
                + "WHERE email = ? and mot_passe = ?";
        
        try (Connection connection = jdbc.getConnection(); PreparedStatement stmt = connection.prepareStatement(sql))
        {
            stmt.setString(1, email);
            stmt.setString(2, mot_passe);
            ResultSet utilisateursAffecte = stmt.executeQuery();
            int nombreUtilisateurAffecte = 0; 
            
            while(utilisateursAffecte.next())
                nombreUtilisateurAffecte++;
            
            if(nombreUtilisateurAffecte > 0)
                return true; 
        }
        catch(ClassNotFoundException ex) 
        {
            ex.printStackTrace();
        }
        catch(SQLException ex) 
        {
            ex.printStackTrace();
        }
        return false; 
    }
}
