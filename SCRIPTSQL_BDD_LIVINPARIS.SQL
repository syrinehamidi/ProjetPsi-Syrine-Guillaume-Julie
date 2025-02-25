DROP DATABASE IF EXISTS LivInParis;

CREATE DATABASE IF NOT EXISTS LivInParis;
USE LivInParis;
# -----------------------------------------------------------------------------
#       TABLE : LIGNEDECOMMANDE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS LIGNEDECOMMANDE
 (
   IDLIGNEDECOMMANDE VARCHAR(128) NOT NULL  ,
   IDLIVRAISON CHAR(32) NOT NULL  ,
   IDCOMMANDE VARCHAR(128) NOT NULL  ,
   DATELIVRAISON DATETIME NOT NULL  ,
   LIEULIVRAISON VARCHAR(128) NOT NULL  
   , PRIMARY KEY (IDLIGNEDECOMMANDE) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE LIGNEDECOMMANDE
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_LIGNEDECOMMANDE_LIVRAISON
     ON LIGNEDECOMMANDE (IDLIVRAISON ASC);

CREATE  INDEX I_FK_LIGNEDECOMMANDE_COMMANDE
     ON LIGNEDECOMMANDE (IDCOMMANDE ASC);

# -----------------------------------------------------------------------------
#       TABLE : COMMANDE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS COMMANDE
 (
   IDCOMMANDE VARCHAR(128) NOT NULL  ,
   IDTIERS VARCHAR(128) NOT NULL  ,
   PRIX REAL(4,2) NOT NULL  ,
   DATECOMMANDE DATETIME NOT NULL  
   , PRIMARY KEY (IDCOMMANDE) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE COMMANDE
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_COMMANDE_CLIENT
     ON COMMANDE (IDTIERS ASC);

# -----------------------------------------------------------------------------
#       TABLE : CUISINIER
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS CUISINIER
 (
   IDTIERS VARCHAR(128) NOT NULL  ,
   NOTE INTEGER NOT NULL  ,
   NOM CHAR(30) NOT NULL  ,
   PRENOM CHAR(35) NOT NULL  ,
   ADRESSE VARCHAR(255) NOT NULL  ,
   CODEPOSTAL VARCHAR(10) NOT NULL  ,
   EMAIL VARCHAR(70) NOT NULL  ,
   TELEPHONE INTEGER NOT NULL  ,
   STATIONMETROPROCHE VARCHAR(40) NOT NULL  
   , PRIMARY KEY (IDTIERS) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : LIVRAISON
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS LIVRAISON
 (
   IDLIVRAISON CHAR(32) NOT NULL  ,
   IDTIERS VARCHAR(128) NOT NULL  ,
   DATELIVRAISON DATETIME NOT NULL  
   , PRIMARY KEY (IDLIVRAISON) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE LIVRAISON
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_LIVRAISON_CUISINIER
     ON LIVRAISON (IDTIERS ASC);

# -----------------------------------------------------------------------------
#       TABLE : TIERS
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS TIERS
 (
   IDTIERS VARCHAR(128) NOT NULL  ,
   NOM CHAR(30) NOT NULL  ,
   PRENOM CHAR(35) NOT NULL  ,
   ADRESSE VARCHAR(255) NOT NULL  ,
   CODEPOSTAL VARCHAR(10) NOT NULL  ,
   EMAIL VARCHAR(70) NOT NULL  ,
   TELEPHONE INTEGER NOT NULL  ,
   STATIONMETROPROCHE VARCHAR(40) NOT NULL  
   , PRIMARY KEY (IDTIERS) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : CLIENT
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS CLIENT
 (
   IDTIERS VARCHAR(128) NOT NULL  ,
   NBCOMMANDES INTEGER NOT NULL  ,
   NOM CHAR(30) NOT NULL  ,
   PRENOM CHAR(35) NOT NULL  ,
   ADRESSE VARCHAR(255) NOT NULL  ,
   CODEPOSTAL VARCHAR(10) NOT NULL  ,
   EMAIL VARCHAR(70) NOT NULL  ,
   TELEPHONE INTEGER NOT NULL  ,
   STATIONMETROPROCHE VARCHAR(40) NOT NULL  
   , PRIMARY KEY (IDTIERS) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : MET
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS MET
 (
   IDMET VARCHAR(128) NOT NULL  ,
   IDTIERS VARCHAR(128) NOT NULL  ,
   NOM VARCHAR(30) NOT NULL  ,
   PHOTO LONGBLOB NOT NULL  ,
   POURCBDEPERS INTEGER NOT NULL  ,
   PRIXPARPERS INTEGER NOT NULL  ,
   DUREECONSERVATION INTEGER NOT NULL  ,
   DESCRIPTION VARCHAR(255) NOT NULL  ,
   ORIGINECULLINAIRE VARCHAR(30) NULL  ,
   REGIMEALIMENTAIRE VARCHAR(30) NULL  
   , PRIMARY KEY (IDMET) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE MET
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_MET_CUISINIER
     ON MET (IDTIERS ASC);

# -----------------------------------------------------------------------------
#       TABLE : INGREDIENT
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS INGREDIENT
 (
   IDINGREDIENT VARCHAR(128) NOT NULL  ,
   NOM VARCHAR(128) NULL  
   , PRIMARY KEY (IDINGREDIENT) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : AVIS
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS AVIS
 (
   IDTIERS VARCHAR(128) NOT NULL  ,
   IDTIERS_1 VARCHAR(128) NOT NULL  ,
   NOTECOMMANDE INTEGER NOT NULL  ,
   COMMENTAIRE VARCHAR(128) NULL  
   , PRIMARY KEY (IDTIERS,IDTIERS_1) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE AVIS
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_AVIS_CUISINIER
     ON AVIS (IDTIERS ASC);

CREATE  INDEX I_FK_AVIS_CLIENT
     ON AVIS (IDTIERS_1 ASC);

# -----------------------------------------------------------------------------
#       TABLE : CONCERNE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS CONCERNE
 (
   IDMET VARCHAR(128) NOT NULL  ,
   IDLIGNEDECOMMANDE VARCHAR(128) NOT NULL  ,
   QUANTITE INTEGER NOT NULL  ,
   PRECISION VARCHAR(255) NULL  
   , PRIMARY KEY (IDMET,IDLIGNEDECOMMANDE) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE CONCERNE
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_CONCERNE_MET
     ON CONCERNE (IDMET ASC);

CREATE  INDEX I_FK_CONCERNE_LIGNEDECOMMANDE
     ON CONCERNE (IDLIGNEDECOMMANDE ASC);

# -----------------------------------------------------------------------------
#       TABLE : COMPOSEDE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS COMPOSEDE
 (
   IDMET VARCHAR(128) NOT NULL  ,
   IDINGREDIENT VARCHAR(128) NOT NULL  ,
   VOLUME REAL(5,2) NOT NULL  
   , PRIMARY KEY (IDMET,IDINGREDIENT) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE COMPOSEDE
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_COMPOSEDE_MET
     ON COMPOSEDE (IDMET ASC);

CREATE  INDEX I_FK_COMPOSEDE_INGREDIENT
     ON COMPOSEDE (IDINGREDIENT ASC);

# -----------------------------------------------------------------------------
#       TABLE : H_AVIS
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS H_AVIS
 (
   IDTIERS_1 VARCHAR(128) NOT NULL  ,
   IDTIERS VARCHAR(128) NOT NULL  ,
   DATE_HISTO DATE NOT NULL  ,
   NOTECOMMANDE INTEGER NOT NULL  ,
   COMMENTAIRE VARCHAR(128) NULL  
   , PRIMARY KEY (IDTIERS_1,IDTIERS,DATE_HISTO) 
 ) 
 comment = "Table d'historisation des modifications de la table AVIS";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE H_AVIS
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_H_AVIS_AVIS
     ON H_AVIS (IDTIERS_1 ASC,IDTIERS ASC);


# -----------------------------------------------------------------------------
#       CREATION DES REFERENCES DE TABLE
# -----------------------------------------------------------------------------


ALTER TABLE LIGNEDECOMMANDE 
  ADD FOREIGN KEY FK_LIGNEDECOMMANDE_LIVRAISON (IDLIVRAISON)
      REFERENCES LIVRAISON (IDLIVRAISON) ;


ALTER TABLE LIGNEDECOMMANDE 
  ADD FOREIGN KEY FK_LIGNEDECOMMANDE_COMMANDE (IDCOMMANDE)
      REFERENCES COMMANDE (IDCOMMANDE) ;


ALTER TABLE COMMANDE 
  ADD FOREIGN KEY FK_COMMANDE_CLIENT (IDTIERS)
      REFERENCES CLIENT (IDTIERS) ;


ALTER TABLE CUISINIER 
  ADD FOREIGN KEY FK_CUISINIER_TIERS (IDTIERS)
      REFERENCES TIERS (IDTIERS) ;


ALTER TABLE LIVRAISON 
  ADD FOREIGN KEY FK_LIVRAISON_CUISINIER (IDTIERS)
      REFERENCES CUISINIER (IDTIERS) ;


ALTER TABLE CLIENT 
  ADD FOREIGN KEY FK_CLIENT_TIERS (IDTIERS)
      REFERENCES TIERS (IDTIERS) ;


ALTER TABLE MET 
  ADD FOREIGN KEY FK_MET_CUISINIER (IDTIERS)
      REFERENCES CUISINIER (IDTIERS) ;


ALTER TABLE AVIS 
  ADD FOREIGN KEY FK_AVIS_CUISINIER (IDTIERS)
      REFERENCES CUISINIER (IDTIERS) ;


ALTER TABLE AVIS 
  ADD FOREIGN KEY FK_AVIS_CLIENT (IDTIERS_1)
      REFERENCES CLIENT (IDTIERS) ;


ALTER TABLE CONCERNE 
  ADD FOREIGN KEY FK_CONCERNE_MET (IDMET)
      REFERENCES MET (IDMET) ;


ALTER TABLE CONCERNE 
  ADD FOREIGN KEY FK_CONCERNE_LIGNEDECOMMANDE (IDLIGNEDECOMMANDE)
      REFERENCES LIGNEDECOMMANDE (IDLIGNEDECOMMANDE) ;


ALTER TABLE COMPOSEDE 
  ADD FOREIGN KEY FK_COMPOSEDE_MET (IDMET)
      REFERENCES MET (IDMET) ;


ALTER TABLE COMPOSEDE 
  ADD FOREIGN KEY FK_COMPOSEDE_INGREDIENT (IDINGREDIENT)
      REFERENCES INGREDIENT (IDINGREDIENT) ;


ALTER TABLE H_AVIS 
  ADD FOREIGN KEY FK_H_AVIS_AVIS (IDTIERS_1,IDTIERS)
      REFERENCES AVIS (IDTIERS_1,IDTIERS) ;

