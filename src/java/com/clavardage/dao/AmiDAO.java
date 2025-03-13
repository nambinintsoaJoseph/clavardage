/**
 * UtilisateurDAO.java
 * 
 * Rôle : 
 * On trouve ici les opérations classique de stockage pour la table Ami
 */

package com.clavardage.dao;

import com.clavardage.beans.Utilisateur;
import com.clavardage.jdbc.Jdbc;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AmiDAO 
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
     * Permet de récuperer les amis d'un utilisateur
     * 
     * @param id_utilisateur, id de l'utilisateur connecté
     * 
     * @return Les utilisateurs qui sont amis de l'utilisateur connecté. 
     * 
     * @throws ClassNotFoundException
     * @throws SQLException 
     */
    public List<Utilisateur> getAmis(int id_utilisateur) throws ClassNotFoundException, SQLException
    {
        List<Utilisateur> amis = new ArrayList<Utilisateur>();
        String sql = "SELECT u.id_utilisateur, u.nom, u.prenom, u.date_naissance, u.residence, u.info_scolaire, " +
                        "u.info_professionnel, u.photo_profil FROM ami a " +
                        "JOIN utilisateur u ON (a.id_demandeur = u.id_utilisateur OR a.id_receveur = u.id_utilisateur) " +
                        "WHERE (a.id_demandeur = ? OR a.id_receveur = ?) " +
                        "AND a.status = 'accepte' " +
                        "AND u.id_utilisateur != ?;";
         try (Connection connection = jdbc.getConnection(); PreparedStatement stmt = connection.prepareStatement(sql))
         {
            stmt.setInt(1, id_utilisateur);
            stmt.setInt(2, id_utilisateur);
            stmt.setInt(3, id_utilisateur);
            ResultSet amiUtilisateur = stmt.executeQuery();

            while(amiUtilisateur.next())
            {
                Utilisateur utilisateur = new Utilisateur();
                utilisateur.setId_utilisateur(amiUtilisateur.getInt("id_utilisateur"));
                utilisateur.setNom(amiUtilisateur.getString("nom"));
                utilisateur.setPrenom(amiUtilisateur.getString("prenom"));
                utilisateur.setDate_naissance(amiUtilisateur.getString("date_naissance"));
                utilisateur.setResidence(amiUtilisateur.getString("residence"));
                utilisateur.setInfo_scolaire(amiUtilisateur.getString("info_scolaire"));
                utilisateur.setInfo_professionnel(amiUtilisateur.getString("info_professionnel"));
                utilisateur.setPhoto_profil(amiUtilisateur.getString("photo_profil"));

                // On ajoute l'utilisateur dans la liste d'ami 
                amis.add(utilisateur);
            }
            return amis; 
         }
         catch(ClassNotFoundException | SQLException ex) 
         {
             ex.printStackTrace();
         }
         return null; 
    }
    
    /**
     * Permet de retirer un utilisateur de la liste d'amis de l'utilisateur actuellement connecté.
     * 
     * @param id_utilisateur : id de l'utilisateur connecté
     * @param id_autre_utilisateur : id de l'ami de l'utilisateur connecté 
     * 
     * @throws ClassNotFoundException
     * @throws SQLException 
     */
    public void retirer(int id_utilisateur, int id_autre_utilisateur) throws ClassNotFoundException, SQLException
    {
        String sql = "DELETE FROM ami " +
                        "WHERE (id_demandeur = ? AND id_receveur = ?) " +
                        "   OR (id_demandeur = ? AND id_receveur = ?) " +
                        "AND status = 'accepte';";
        executeSQLCommand(sql, id_utilisateur, id_autre_utilisateur, id_autre_utilisateur, id_utilisateur);
    }
    
    /**
     * Permet à l'utilisateur d'ajouter un ami.
     * 
     * @param id_utilisateur : celui qui envoi la demande 
     * @param id_autre_utilisateur : celui qui reçoit la demande
     * 
     * @throws ClassNotFoundException
     * @throws SQLException 
     */
    public void ajouter(int id_utilisateur, int id_autre_utilisateur) throws ClassNotFoundException, SQLException 
    {
        String sql = "INSERT INTO ami (id_demandeur, id_receveur, status) " +
                        "VALUES (?, ?, 'en_attente');";
        executeSQLCommand(sql, id_utilisateur, id_autre_utilisateur);
    }
}
