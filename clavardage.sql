CREATE TABLE IF NOT EXISTS utilisateur(
    id_utilisateur BIGINT(11) NOT NULL AUTO_INCREMENT, 
    nom VARCHAR(50) NOT NULL, 
    prenom VARCHAR(50) NOT NULL, 
    date_naissance DATE NOT NULL, 
    email VARCHAR(50) NOT NULL, 
    mot_passe TEXT NOT NULL, 
    residence VARCHAR(50), 
    info_scolaire VARCHAR(50), 
    info_professionnel VARCHAR(50), 
    photo_profil TEXT, 
    PRIMARY KEY (id_utilisateur)
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS ami(
    id_ami BIGINT(11) NOT NULL AUTO_INCREMENT, 
    id_demandeur BIGINT(11) NOT NULL, 
    id_receveur BIGINT(11) NOT NULL, 
    status VARCHAR(15) NOT NULL, 
    date_demande DATETIME NOT NULL DEFAULT current_timestamp(),
    FOREIGN KEY (id_demandeur) REFERENCES utilisateur(id_utilisateur) ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY (id_receveur) REFERENCES utilisateur(id_utilisateur) ON DELETE CASCADE ON UPDATE CASCADE, 
    PRIMARY KEY(id_ami)
) ENGINE=INNODB; 

CREATE TABLE IF NOT EXISTS conversation(
    id_conversation BIGINT(11) NOT NULL AUTO_INCREMENT, 
    titre VARCHAR(30), 
    date_creation DATETIME NOT NULL DEFAULT current_timestamp(), 
    PRIMARY KEY(id_conversation)
) ENGINE=INNODB; 

CREATE TABLE IF NOT EXISTS conversationutilisateur(
    id_conversation_utilisateur BIGINT(11) NOT NULL AUTO_INCREMENT, 
    id_conversation BIGINT(11) NOT NULL, 
    id_utilisateur BIGINT(11) NOT NULL, 
    FOREIGN KEY (id_conversation) REFERENCES conversation(id_conversation) ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur) ON DELETE CASCADE ON UPDATE CASCADE, 
    PRIMARY KEY(id_conversation_utilisateur)
) ENGINE=INNODB; 

CREATE TABLE IF NOT EXISTS message(
    id_message BIGINT(11) NOT NULL AUTO_INCREMENT, 
    id_conversation BIGINT(11) NOT NULL, 
    id_utilisateur BIGINT(11) NOT NULL, 
    contenu TEXT NOT NULL, 
    date_envoi DATETIME NOT NULL DEFAULT current_timestamp(), 
    est_lu TINYINT(1) NOT NULL DEFAULT 0,
    nom_fichier TEXT, 
    chemin_fichier TEXT, 
    taille_fichier DOUBLE DEFAULT NULL, 
    FOREIGN KEY (id_conversation) REFERENCES conversation(id_conversation) ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(id_message)
) ENGINE=INNODB; 

CREATE TABLE IF NOT EXISTS notification(
    id_notification BIGINT(11) NOT NULL AUTO_INCREMENT, 
    id_utilisateur BIGINT(11) NOT NULL, 
    contenu_notification TEXT NOT NULL, 
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur) ON DELETE CASCADE ON UPDATE CASCADE, 
    PRIMARY KEY (id_notification)
) ENGINE=INNODB; 