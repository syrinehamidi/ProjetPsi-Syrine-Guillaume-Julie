DROP DATABASE IF EXISTS livinparis;

CREATE DATABASE IF NOT EXISTS livinparis;
USE livinparis;
# -----------------------------------------------------------------------------
#       TABLE : ligneDeCommande
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ligneDeCommande
 (
   idMet INTEGER NOT NULL  ,
   idCommande INTEGER NOT NULL  ,
   idLivraison INTEGER NOT NULL  ,
   dateLivraison DATETIME NOT NULL  ,
   lieuLivraison VARCHAR(128) NOT NULL  ,
   quantite INTEGER NOT NULL  ,
   precisions VARCHAR(255) NULL  
   , PRIMARY KEY (idMet,idCommande,idLivraison) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE ligneDeCommande
# -----------------------------------------------------------------------------


CREATE  INDEX iFkLigneDeCommandeLivraison
     ON ligneDeCommande (idLivraison ASC);

CREATE  INDEX iFkLigneDeCommandeCommande
     ON ligneDeCommande (idCommande ASC);

CREATE  INDEX iFkLigneDeCommandeMet
     ON ligneDeCommande (idMet ASC);

# -----------------------------------------------------------------------------
#       TABLE : commande
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS commande
 (
   idCommande INTEGER NOT NULL  ,
   idTiers INTEGER NOT NULL  ,
   prix REAL(4,2) NOT NULL  ,
   dateCommande DATETIME NOT NULL  
   , PRIMARY KEY (idCommande) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE commande
# -----------------------------------------------------------------------------


CREATE  INDEX iFkCommandeClient
     ON commande (idTiers ASC);

# -----------------------------------------------------------------------------
#       TABLE : cuisinier
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS cuisinier
 (
   idTiers INTEGER NOT NULL  ,
   note INTEGER NOT NULL  ,
   nom CHAR(30) NOT NULL  ,
   prenom CHAR(35) NOT NULL  ,
   adresse VARCHAR(255) NOT NULL  ,
   codePostal INTEGER NOT NULL  ,
   email VARCHAR(70) NOT NULL  ,
   telephone INTEGER NOT NULL  ,
   stationMetroProche VARCHAR(40) NOT NULL  
   , PRIMARY KEY (idTiers) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : livraison
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS livraison
 (
   idLivraison INTEGER NOT NULL  ,
   idTiers INTEGER NOT NULL  ,
   dateLivraison DATETIME NOT NULL  
   , PRIMARY KEY (idLivraison) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE livraison
# -----------------------------------------------------------------------------


CREATE  INDEX iFkLivraisonCuisinier
     ON livraison (idTiers ASC);

# -----------------------------------------------------------------------------
#       TABLE : tiers
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS tiers
 (
   idTiers INTEGER NOT NULL  ,
   nom CHAR(30) NOT NULL  ,
   prenom CHAR(35) NOT NULL  ,
   adresse VARCHAR(255) NOT NULL  ,
   codePostal INTEGER NOT NULL  ,
   email VARCHAR(70) NOT NULL  ,
   telephone INTEGER NOT NULL  ,
   stationMetroProche VARCHAR(40) NOT NULL  
   , PRIMARY KEY (idTiers) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : client
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS client
 (
   idTiers INTEGER NOT NULL  ,
   nbCommandes INTEGER NOT NULL  ,
   nom CHAR(30) NOT NULL  ,
   prenom CHAR(35) NOT NULL  ,
   adresse VARCHAR(255) NOT NULL  ,
   codePostal INTEGER NOT NULL  ,
   email VARCHAR(70) NOT NULL  ,
   telephone INTEGER NOT NULL  ,
   stationMetroProche VARCHAR(40) NOT NULL  
   , PRIMARY KEY (idTiers) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : note
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS note
 (
   idTiers1 INTEGER NOT NULL  ,
   idTiers INTEGER NOT NULL  ,
   dateNote INTEGER NOT NULL  ,
   noteCommande INTEGER NOT NULL  ,
   commentaire VARCHAR(255) NULL  
   , PRIMARY KEY (idTiers1,idTiers,dateNote) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE note
# -----------------------------------------------------------------------------


CREATE  INDEX iFkNoteCuisinier
     ON note (idTiers ASC);

CREATE  INDEX iFkNoteClient
     ON note (idTiers1 ASC);

# -----------------------------------------------------------------------------
#       TABLE : met
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS met
 (
   idMet INTEGER NOT NULL  ,
   idTiers INTEGER NOT NULL  ,
   nom VARCHAR(30) NOT NULL  ,
   photo LONGBLOB NOT NULL  ,
   pourcBDepers INTEGER NOT NULL  ,
   prixParPers INTEGER NOT NULL  ,
   dureeConservation INTEGER NOT NULL  ,
   description VARCHAR(255) NOT NULL  ,
   origineCulinaire VARCHAR(30) NULL  ,
   regimeAlimentaire VARCHAR(30) NULL  
   , PRIMARY KEY (idMet) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE met
# -----------------------------------------------------------------------------


CREATE  INDEX iFkMetCuisinier
     ON met (idTiers ASC);

# -----------------------------------------------------------------------------
#       TABLE : ingredient
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ingredient
 (
   idIngredient INTEGER NOT NULL  ,
   nom VARCHAR(128) NULL  
   , PRIMARY KEY (idIngredient) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : compositionMet
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS compositionMet
 (
   idMet INTEGER NOT NULL  ,
   idIngredient INTEGER NOT NULL  ,
   volume REAL(5,2) NOT NULL  
   , PRIMARY KEY (idMet,idIngredient) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE compositionMet
# -----------------------------------------------------------------------------


CREATE  INDEX iFkCompositionMetMet
     ON compositionMet (idMet ASC);

CREATE  INDEX iFkCompositionMetIngredient
     ON compositionMet (idIngredient ASC);


# -----------------------------------------------------------------------------
#       CREATION DES REFERENCES DE TABLE
# -----------------------------------------------------------------------------


ALTER TABLE ligneDeCommande 
  ADD FOREIGN KEY fkLigneDeCommandeLivraison (idLivraison)
      REFERENCES livraison (idLivraison) ;


ALTER TABLE ligneDeCommande 
  ADD FOREIGN KEY fkLigneDeCommandeCommande (idCommande)
      REFERENCES commande (idCommande) ;


ALTER TABLE ligneDeCommande 
  ADD FOREIGN KEY fkLigneDeCommandeMet (idMet)
      REFERENCES met (idMet) ;


ALTER TABLE commande 
  ADD FOREIGN KEY fkCommandeClient (idTiers)
      REFERENCES client (idTiers) ;


ALTER TABLE cuisinier 
  ADD FOREIGN KEY fkCuisinierTiers (idTiers)
      REFERENCES tiers (idTiers) ;


ALTER TABLE livraison 
  ADD FOREIGN KEY fkLivraisonCuisinier (idTiers)
      REFERENCES cuisinier (idTiers) ;


ALTER TABLE client 
  ADD FOREIGN KEY fkClientTiers (idTiers)
      REFERENCES tiers (idTiers) ;


ALTER TABLE note 
  ADD FOREIGN KEY fkNoteCuisinier (idTiers)
      REFERENCES cuisinier (idTiers) ;


ALTER TABLE note 
  ADD FOREIGN KEY fkNoteClient (idTiers1)
      REFERENCES client (idTiers) ;


ALTER TABLE met 
  ADD FOREIGN KEY fkMetCuisinier (idTiers)
      REFERENCES cuisinier (idTiers) ;


ALTER TABLE compositionMet 
  ADD FOREIGN KEY fkCompositionMetMet (idMet)
      REFERENCES met (idMet) ;


ALTER TABLE compositionMet 
  ADD FOREIGN KEY fkCompositionMetIngredient (idIngredient)
      REFERENCES ingredient (idIngredient) ;
      
      
      
      
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Cuisiniers.csv' 
INTO TABLE tiers  
FIELDS TERMINATED BY ';' 
LINES STARTING BY '' 
TERMINATED BY '\r\n' 
IGNORE 1 LINES
(idtiers,nom,prenom,adresse,codepostal,email,telephone,stationmetroproche); 

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Cuisiniers.csv' 
INTO TABLE cuisinier  
FIELDS TERMINATED BY ';' 
LINES STARTING BY '' 
TERMINATED BY '\r\n' 
IGNORE 1 LINES
(idtiers,nom,prenom,adresse,codepostal,email,telephone,stationmetroproche); 


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Clients.csv' 
INTO TABLE tiers  
FIELDS TERMINATED BY ';' 
LINES STARTING BY '' 
TERMINATED BY '\r\n' 
IGNORE 1 LINES
(idtiers,nom,prenom,adresse,codepostal,email,telephone,stationmetroproche);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Clients.csv' 
INTO TABLE client
FIELDS TERMINATED BY ';' 
LINES STARTING BY '' 
TERMINATED BY '\r\n' 
IGNORE 1 LINES
(idtiers,nom,prenom,adresse,codepostal,email,telephone,stationmetroproche);


SELECT * FROM tiers;
SELECT * FROM cuisinier;
SELECT * FROM client;