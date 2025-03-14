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

// Bibliothèque de hashage (pour vérifier qu'un mot de passe correspont au hash stocké dans la base de données)
import org.mindrot.jbcrypt.BCrypt; 

public class UtilisateurDAO 
{
    private final Jdbc jdbc = new Jdbc();
    
    /**
     * Exécute une requête SQL
     * 
     * @param sql La requête sql que l'on souhaite exécuter.
     * @param params Les paramètres à insérer dans une requête preparée.
     * 
     * @throws ClassNotFoundException 
     * @throws SQLException
     */
    private void executeSQLCommand(String sql, Object... params) throws ClassNotFoundException, SQLException
    {
        try(Connection connection = jdbc.getConnection();
            PreparedStatement stmt = connection.prepareStatement(sql))
        {
            for(int i = 0; i < params.length; i++)
            {
                stmt.setObject(i+1, params[i]);
            }
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
     * Permet d'ajouter un utilisateur
     * 
     * @param utilisateur bean java qui represente la table utilisateur du côté orienté objet. 
     * 
     * @throws ClassNotFoundException
     * @throws SQLException 
     */
    public void addUtilisateur(Utilisateur utilisateur) throws ClassNotFoundException, SQLException 
    {
        String sql = "INSERT INTO utilisateur(nom, prenom, date_naissance, email, mot_passe) VALUES(?, ?, ?, ?, ?)";
        executeSQLCommand(sql, utilisateur.getNom(), utilisateur.getPrenom(), utilisateur.getDate_naissance(), 
                utilisateur.getEmail(), utilisateur.getMot_passe());
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
        String sql = "UPDATE utilisateur SET nom = ?, prenom = ?, date_naissance = ?, "
                + "email = ?, residence = ?, info_scolaire = ?, "
                + "info_professionnel = ?, photo_profil = ? WHERE id_utilisateur = ?";
        executeSQLCommand(sql, utilisateur.getNom(), utilisateur.getPrenom(),
                utilisateur.getDate_naissance(), utilisateur.getEmail(),
                utilisateur.getResidence(), utilisateur.getInfo_scolaire(), utilisateur.getInfo_professionnel(), 
                utilisateur.getPhoto_profil(), utilisateur.getId_utilisateur());
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
        String sql = "DELETE FROM utilisateur WHERE id_utilisateur = ?";
        executeSQLCommand(sql, utilisateur.getId_utilisateur());
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
                    utilisateur.setId_utilisateur(utilisateurTrouve.getInt("id_utilisateur"));
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
        List<Utilisateur> utilisateurs = new ArrayList<Utilisateur>();
        String sql = "SELECT id_utilisateur, nom, prenom, residence, info_scolaire, info_professionnel, photo_profil "
                + "FROM utilisateur WHERE LOWER(nom) = LOWER(?) OR LOWER(prenom) = LOWER(?)";
        
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
                utilisateur.setInfo_scolaire(utilisateursTrouve.getString("info_scolaire"));
                utilisateur.setInfo_professionnel(utilisateursTrouve.getString("info_professionnel"));
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
     * Permet de récuperer l'id_utilisateur récement ajouté  dans la base de données. 
     * 
     * @return id_utilisateur en cas de succès, -1 sinon 
     * 
     * @throws SQLException
     * @throws ClassNotFoundException 
     */
    public int getLastInsertIdUtilisateur() throws SQLException, ClassNotFoundException
    {
        String sql = "SELECT MAX(id_utilisateur) AS last_insert_id FROM utilisateur"; 
        ResultSet resultat = jdbc.getConnection().createStatement().executeQuery(sql);
        
        if(resultat.next())
            return resultat.getInt("last_insert_id");
        
        return -1;
    }
    
    /**
     * Permet d'authentifier un utilisateur.
     * 
     * @param email email de l'utilisateur
     * @param mot_passe mot de passe de l'utilisateur.
     * 
     * @return true si les informations d'authentification sont corretes, false sinon.
     */
    public Utilisateur authentificateUtilisateur(String email, String mot_passe) throws ClassNotFoundException, SQLException 
    {
        String sql = "SELECT id_utilisateur, email, mot_passe FROM utilisateur WHERE email = ?";

        try (Connection connection = jdbc.getConnection(); PreparedStatement stmt = connection.prepareStatement(sql)) {
            // On remplace seulement l'email, pas le mot de passe
            stmt.setString(1, email); 

            ResultSet utilisateurAffecte = stmt.executeQuery();

            if (utilisateurAffecte.next()) {
                // Récupère le hash du mot de passe stocké dans la base de données
                String mot_passe_hashe = utilisateurAffecte.getString("mot_passe");

                // Compare le mot de passe fourni avec le hash stocké dans la base de données
                if (BCrypt.checkpw(mot_passe, mot_passe_hashe)) {
                    Utilisateur utilisateur = new Utilisateur(); 
                    System.out.println("authentificateUtilisateur : " + utilisateurAffecte.getInt("id_utilisateur")); 
                    utilisateur = this.findUtilisateurById(utilisateurAffecte.getInt("id_utilisateur")); 
                    return utilisateur;
                }
            }
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
        } 

        return null; 
    }   
}
