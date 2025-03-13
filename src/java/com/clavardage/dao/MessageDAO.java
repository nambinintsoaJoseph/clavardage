package com.clavardage.dao;

import com.clavardage.beans.Message;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.clavardage.jdbc.Jdbc;

public class MessageDAO {
    private final Jdbc jdbc = new Jdbc();

    //  Envoyer un message (ajouter un message à une conversation) 
    public void envoyerMessage(Message message) throws ClassNotFoundException, SQLException 
    {
        String sql = "INSERT INTO message (id_conversation, id_utilisateur, contenu, date_envoi, est_lu, nom_fichier, chemin_fichier, taille_fichier) " +
                     "VALUES (?, ?, ?, NOW(), ?, ?, ?, ?)";
       try (Connection connection = jdbc.getConnection(); PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS))
        {
            stmt.setInt(1, message.getId_conversation());
            stmt.setInt(2, message.getId_utilisateur());
            stmt.setString(3, message.getContenu());
            stmt.setBoolean(4, message.isEst_lu());
            stmt.setString(5, message.getNom_fichier());
            stmt.setString(6, message.getChemin_fichier());
            stmt.setDouble(7, message.getTaille_fichier());

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted == 0) 
            {
                throw new SQLException("Échec de l'envoi du message, aucune ligne ajoutée.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) 
            {
                if (generatedKeys.next()) 
                {
                    message.setId_message(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("Échec de l'envoi du message, aucun ID généré.");
                }
            }
        }
    }

    // Récupérer tous les messages d'une conversation
    public List<Message> getMessagesByConversation(int id_conversation) throws ClassNotFoundException, SQLException 
    {
        List<Message> messages = new ArrayList<>();
        String sql = "SELECT * FROM message WHERE id_conversation = ? ORDER BY date_envoi ASC";

        try (Connection connection = jdbc.getConnection(); PreparedStatement stmt = connection.prepareStatement(sql))
        {
            stmt.setInt(1, id_conversation);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Message message = new Message();
                    message.setId_message(rs.getInt("id_message"));
                    message.setId_conversation(rs.getInt("id_conversation"));
                    message.setId_utilisateur(rs.getInt("id_utilisateur"));
                    message.setContenu(rs.getString("contenu"));
                    message.setDate_envoi(rs.getString("date_envoi"));
                    message.setEst_lu(rs.getBoolean("est_lu"));
                    message.setNom_fichier(rs.getString("nom_fichier"));
                    message.setChemin_fichier(rs.getString("chemin_fichier"));
                    message.setTaille_fichier(rs.getDouble("taille_fichier"));
                    messages.add(message);
                }
            }
        }
        return messages;
    }

    //  Marquer un message comme lu
    public boolean marquerMessageCommeLu(int id_message) throws ClassNotFoundException, SQLException 
    {
        String sql = "UPDATE message SET est_lu = 1 WHERE id_message = ?";
        try (Connection connection = jdbc.getConnection(); PreparedStatement stmt = connection.prepareStatement(sql))
        {
            stmt.setInt(1, id_message);
            return stmt.executeUpdate() > 0; // Retourne true si la mise à jour a été effectuée
        }
    }

    // Supprimer un message
    public boolean supprimerMessage(int id_message) throws ClassNotFoundException, SQLException 
    {
        String sql = "DELETE FROM message WHERE id_message = ?";
        try (Connection connection = jdbc.getConnection(); PreparedStatement stmt = connection.prepareStatement(sql))
        {
            stmt.setInt(1, id_message);
            return stmt.executeUpdate() > 0; // Retourne true si une ligne a été supprimée
        }
    }
}
