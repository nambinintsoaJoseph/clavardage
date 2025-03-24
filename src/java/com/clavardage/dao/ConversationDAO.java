package com.clavardage.dao;

import com.clavardage.beans.Conversation;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.clavardage.jdbc.Jdbc;

public class ConversationDAO {
    private final Jdbc jdbc = new Jdbc();

    // Ajouter une conversation 
    public void ajouterConversation(Conversation conversation) throws ClassNotFoundException, SQLException {
        String sql = "INSERT INTO conversation (titre) VALUES (?)";
        try (Connection connection = jdbc.getConnection(); PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS))
        {
            stmt.setString(1, conversation.getTitre());
            
            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted == 0) {
                throw new SQLException("Échec de la création de la conversation, aucune ligne ajoutée.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    conversation.setId_conversation(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("Échec de la création de la conversation, aucun ID généré.");
                }
            }
        }
    }

    // Récupérer une conversation par ID
    public Conversation getConversationById(int id) throws ClassNotFoundException, SQLException 
    {
        String sql = "SELECT * FROM conversation WHERE id_conversation = ?";
        try (Connection connection = jdbc.getConnection(); PreparedStatement stmt = connection.prepareStatement(sql))
        {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Conversation conversation = new Conversation();
                    conversation.setId_conversation(rs.getInt("id_conversation"));
                    conversation.setTitre(rs.getString("titre"));
                    conversation.setDate_creation(rs.getString("date_creation"));
                    return conversation;
                }
            }
        }
        return null; // Si aucune conversation trouvée
    }

    // Lister toutes les conversations
    public List<Conversation> getAllConversations() throws ClassNotFoundException, SQLException 
    {
        List<Conversation> conversations = new ArrayList<>();
        String sql = "SELECT * FROM conversation ORDER BY date_creation DESC";

        try (Connection connection = jdbc.getConnection(); PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) 
            {
                Conversation conversation = new Conversation();
                conversation.setId_conversation(rs.getInt("id_conversation"));
                conversation.setTitre(rs.getString("titre"));
                conversation.setDate_creation(rs.getString("date_creation"));
                conversations.add(conversation);
            }
        }
        return conversations;
    }

    // Supprimer une conversation
    public boolean supprimerConversation(int id) throws ClassNotFoundException, SQLException 
    {
        String sql = "DELETE FROM conversation WHERE id_conversation = ?";
        try (Connection connection = jdbc.getConnection(); PreparedStatement stmt = connection.prepareStatement(sql))
        {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0; // Retourne true si une ligne a été supprimée
        }
    }
    
    // Récuperer les conversation d'un utilisateur : 
    public List<Conversation> getConversationUtilisateur(int id_utilisateur) throws ClassNotFoundException, SQLException 
    {
        List<Conversation> conversations = new ArrayList<Conversation>(); 
        String sql = "SELECT " +
                    " conversation.id_conversation, " +
                    " conversation.titre, "
                    + " conversation.date_creation" +
                    " FROM conversation " +
                    " JOIN conversationutilisateur " +
                    " ON conversation.id_conversation = conversationutilisateur.id_conversation " +
                    " WHERE conversationutilisateur.id_utilisateur = ?;";
        try (Connection connection = jdbc.getConnection(); PreparedStatement stmt = connection.prepareStatement(sql))
        {
            stmt.setInt(1, id_utilisateur);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Conversation conversation = new Conversation();
                    conversation.setId_conversation(rs.getInt("id_conversation"));
                    conversation.setTitre(rs.getString("titre"));
                    conversation.setDate_creation(rs.getString("date_creation"));
           
                    conversations.add(conversation); 
                }
            }
            return conversations; 
        }
    }
}
