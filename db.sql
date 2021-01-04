-- ============================================================
--   Drop table pour pouvoir les recréée
-- ============================================================

DROP TABLE IF EXISTS produit, fournisseur, acheteur, transaction_ap;

-- ============================================================
--   Table : des fournisseurs
-- ============================================================

CREATE TABLE fournisseur
(
    idFournisseur serial primary key,
    nom           text not null,
    prenom        text not null,
    date          date,
    email         varchar check ( email ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$' ),
    adresse       text,
    sexe          text check (sexe in ('Homme', 'Femme', 'Unknown')),
    solde         numeric DEFAULT 0.0
);

-- ============================================================
--   Table : des acheteurs (peut acheter mais pas mettre en vente)
-- ============================================================

CREATE TABLE Acheteur
(
    idAcheteur serial primary key,
    nom        text not null,
    prenom     text not null,
    date       date,
    email      varchar check ( email ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$' ),
    adresse    text,
    sexe       text check (sexe in ('Homme', 'Femme', 'Unknown'))
);

-- ============================================================
--   Table : des produits
-- ============================================================

CREATE TABLE Produit
(
    idProduit     serial,
    nom           text    not null,
    prix          numeric CHECK ( prix >= 0 ),
    quantite      int     not null CHECK ( quantite >= 0 ),
    description   text,
    idFournisseur int,
    FOREIGN KEY (idFournisseur) REFERENCES fournisseur (idFournisseur),
    PRIMARY KEY (idProduit)
);

-- ============================================================
--   Table : des transactions
-- ============================================================

CREATE TABLE transaction_ap
(
    idTransaction serial,
    idAcheteur    int,
    idProduit     int,
    idFournisseur int,
    FOREIGN KEY (idAcheteur) REFERENCES Acheteur (idAcheteur),
    FOREIGN KEY (idProduit) REFERENCES Produit (idProduit),
    FOREIGN KEY (idFournisseur) REFERENCES fournisseur (idFournisseur),
    PRIMARY KEY (idTransaction)
);

-- ============================================================
--   Jeux de test
-- ============================================================

-- ==============
--   Fournisseur
-- ==============

INSERT INTO fournisseur
VALUES (DEFAULT, 'Thomas', 'Aymeric', '2001-10-24', 'aymeric.ths@gmail.com', '19 la zone BERLAIM', 'Homme', DEFAULT),
       (DEFAULT, 'Ober', 'Lucas', '2006-06-06', 'lucas.obr@gmail.com', '18 la zone PERDUE', 'Unknown', DEFAULT),
       (DEFAULT, 'Lecuyer', 'Bastien', '2001-08-08', 'bastien.lcy@gmail.com', '18 la zone la vrai', 'Homme', DEFAULT),
       (DEFAULT, 'Pruvot', 'Julien', '2001-08-08', 'julien.pvt@gmail.com', '17 la zone la vrai', 'Homme', DEFAULT);

-- ==============
--   Acheteur
-- ==============

INSERT INTO Acheteur
VALUES (DEFAULT, 'Pigeon', 'Jean-Michel', '2001-10-01', 'Pigeon.jm@outlook.com', '01 la zone BERLAIM', 'Homme'),
       (DEFAULT, 'Random', 'Romi', '2006-06-07', 'random.rm@jsp.com', '02 la zone PERDUE', 'Unknown'),
       (DEFAULT, 'Miaou', 'Chachat', '2001-08-18', 'miaou.chty@outlook.com', '03 la zone la vrai', 'Unknown'),
       (DEFAULT, 'Bark', 'Kev', '2001-08-09', 'bark.kev@gmail.com', '04 la zone la vrai', 'Homme');

-- ==============
--   produit
-- ==============

INSERT INTO produit
VALUES (DEFAULT,'Tormion',1,1000000.00,'La fusion incroyable entre une tortue et un camion',2),
       (DEFAULT,'Chaise',1500,12.99,'Une chaise où reste debout de préférence',1),
       (DEFAULT,'Table',1000,51.99,'Une table où on mange, enfin je pense',1),
       (DEFAULT,'Télévision',10,499.99,'La 4K et tout mon pote',4);

-- ==============
--   Transaction_ap
-- ==============

INSERT INTO transaction_ap
VALUES (DEFAULT,1,1,2);