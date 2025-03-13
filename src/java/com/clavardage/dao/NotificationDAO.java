package com.clavardage.dao;

import com.clavardage.beans.Notification;
import com.clavardage.jdbc.Jdbc;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO 
{
    private final Jdbc jdbc = new Jdbc();

    // Ajouter une notification
    public void ajouterNotification(Notification notification) throws ClassNotFoundException, SQLException 
    {
        String sql = "INSERT INTO notification (id_utilisateur, contenu_notification) VALUES (?, ?)";
         try (Connection connection = jdbc.getConnection(); PreparedStatement stmt = connection.prepareStatement(sql))
        {
            stmt.setInt(1, notification.getId_utilisateur());
            stmt.setString(2, notification.getContenu());
            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted == 0) 
            {
                throw new SQLException("Échec de l'ajout de la notification.");
            }
        }
    }

    // Récupérer toutes les notifications d'un utilisateur
    public List<Notification> getNotificationsParUtilisateur(int id_utilisateur) throws ClassNotFoundException, SQLException {
        List<Notification> notifications = new ArrayList<>();
        String sql = "SELECT * FROM notification WHERE id_utilisateur = ?";

        try (Connection connection = jdbc.getConnection(); PreparedStatement stmt = connection.prepareStatement(sql))
        {
            stmt.setInt(1, id_utilisateur);
            try (ResultSet rs = stmt.executeQuery()) 
            {
                while (rs.next()) 
                {
                    Notification notification = new Notification();
                    notification.setId_notification(rs.getInt("id_notification"));
                    notification.setId_utilisateur(rs.getInt("id_utilisateur"));
                    notification.setContenu(rs.getString("contenu_notification"));
                    notifications.add(notification);
                }
            }
        }
        return notifications;
    }

    //  Supprimer une notification
    public boolean supprimerNotification(int id_notification) throws ClassNotFoundException, SQLException {
        String sql = "DELETE FROM notification WHERE id_notification = ?";
        try (Connection connection = jdbc.getConnection(); PreparedStatement stmt = connection.prepareStatement(sql))
        {
            stmt.setInt(1, id_notification);
            return stmt.executeUpdate() > 0; // Retourne true si la notification a été supprimée
        }
    }
}
