package com.clavardage.dao;

import com.clavardage.beans.ConversationUtilisateur;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.clavardage.jdbc.Jdbc;

public class ConversationUtilisateurDAO {
    private final Jdbc jdbc = new Jdbc();

    // Ajouter un utilisateur dans une conversation
    public void ajouterUtilisateurDansConversation(ConversationUtilisateur conversationUtilisateur) throws ClassNotFoundException, SQLException 
    {
        String sql = "INSERT INTO conversationutilisateur (id_conversation, id_utilisateur) VALUES (?, ?)";
        try (Connection connection = jdbc.getConnection(); PreparedStatement stmt = connection.prepareStatement(sql))
        {
            stmt.setInt(1, conversationUtilisateur.getId_conversation());
            stmt.setInt(2, conversationUtilisateur.getId_utilisateur());
            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted == 0) 
            {
                throw new SQLException("Échec de l'ajout de l'utilisateur dans la conversation.");
            }
        }
    }

    //  Récupérer tous les utilisateurs d'une conversation
    public List<Integer> getUtilisateursParConversation(int id_conversation) throws ClassNotFoundException, SQLException 
    {
        List<Integer> utilisateurs = new ArrayList<>();
        String sql = "SELECT id_utilisateur FROM conversationutilisateur WHERE id_conversation = ?";

        try (Connection connection = jdbc.getConnection(); PreparedStatement stmt = connection.prepareStatement(sql))
        {
            stmt.setInt(1, id_conversation);
            try (ResultSet rs = stmt.executeQuery()) 
            {
                while (rs.next()) 
                {
                    utilisateurs.add(rs.getInt("id_utilisateur"));
                }
            }
        }
        return utilisateurs;
    }

    //  Supprimer un utilisateur d'une conversation
    public boolean supprimerUtilisateurDeConversation(int id_conversation, int id_utilisateur) throws ClassNotFoundException, SQLException 
    {
        String sql = "DELETE FROM conversationutilisateur WHERE id_conversation = ? AND id_utilisateur = ?";
        try (Connection connection = jdbc.getConnection(); PreparedStatement stmt = connection.prepareStatement(sql))
        {
            stmt.setInt(1, id_conversation);
            stmt.setInt(2, id_utilisateur);
            return stmt.executeUpdate() > 0; // Retourne true si l'utilisateur a été supprimé de la conversation
        }
    }
}
