--
--  DEFINIZIONE DELLE TABELLE
--

CREATE TABLE IF NOT EXISTS Sesso (
    value CHAR(1) PRIMARY KEY
);

INSERT INTO Sesso (value)
VALUES  ('M'),
        ('F');


CREATE OR REPLACE TABLE Utente (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(30) NOT NULL UNIQUE,
    password CHAR(60) NOT NULL,
    -- 60 character is the output length of the implemented hash function
    cognome VARCHAR(30) NOT NULL,
    nome VARCHAR(30) NOT NULL,
    data_nascita DATE NOT NULL,
    sesso CHAR(1) NOT NULL,
    email VARCHAR(50) UNIQUE,
    telefono VARCHAR(15) UNIQUE,
    FOREIGN KEY (sesso) REFERENCES Sesso(value) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `numero_tel` CHECK (`telefono` REGEXP '^[+]?([0-9]{6}[0-9]*)$'),
    CONSTRAINT `email_format` CHECK (`email` REGEXP '^[A-Za-z0-9][A-Za-z0-9-.]+[A-Za-z0-9]@([A-Za-z0-9-]+.)+[A-Za-z0-9]+')
);

CREATE TABLE IF NOT EXISTS Atleta (
    utente INT UNSIGNED PRIMARY KEY,
    FOREIGN KEY (utente) REFERENCES Utente(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Tutore (
    utente INT UNSIGNED PRIMARY KEY,
    FOREIGN KEY (utente) REFERENCES Utente(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Allenatore (
    utente INT UNSIGNED PRIMARY KEY,
    FOREIGN KEY (utente) REFERENCES Utente(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Dirigente (
    utente INT UNSIGNED PRIMARY KEY,
    FOREIGN KEY (utente) REFERENCES Utente(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Ruolo (
    nome VARCHAR(30) PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS Assunzione (
    ruolo VARCHAR(30),
    atleta INT UNSIGNED,
    PRIMARY KEY (ruolo, atleta),
    FOREIGN KEY (atleta) REFERENCES Atleta(utente) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ruolo) REFERENCES Ruolo(nome) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS Tutela (
    atleta INT UNSIGNED,
    tutore INT UNSIGNED,
    PRIMARY KEY (atleta, tutore),
    FOREIGN KEY (atleta) REFERENCES Atleta(utente) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (tutore) REFERENCES Tutore(utente) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Stagione (
    anno_inizio SMALLINT UNSIGNED PRIMARY KEY,
    anno_fine SMALLINT UNSIGNED NOT NULL,
    corrente BOOLEAN NOT NULL,
    CONSTRAINT inizio_e_fine CHECK(anno_inizio < anno_fine)
);

CREATE TABLE IF NOT EXISTS Categoria (
    id VARCHAR(4) PRIMARY KEY,
    nome VARCHAR(20) NOT NULL,
    tipo ENUM('RUGBY', 'MINIRUGBY') NOT NULL,
    eta_min TINYINT UNSIGNED NOT NULL,
    eta_max TINYINT UNSIGNED NOT NULL,
    sesso CHAR(1),
    FOREIGN KEY (sesso) REFERENCES Sesso(value) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT eta_min_max CHECK(eta_min < eta_max)
);

CREATE TABLE IF NOT EXISTS Squadra (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    categoria VARCHAR(4) NOT NULL,
    stagione SMALLINT UNSIGNED NOT NULL,
    anno_min SMALLINT UNSIGNED NOT NULL,
    anno_max SMALLINT UNSIGNED NOT NULL,
    CONSTRAINT anno_min_max CHECK(anno_min < anno_max),
    CONSTRAINT categoria_stagione UNIQUE (categoria, stagione),
    FOREIGN KEY (categoria) REFERENCES Categoria(id) ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (stagione) REFERENCES Stagione(anno_inizio) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Rosa (
    atleta INT UNSIGNED,
    squadra INT UNSIGNED,
    PRIMARY KEY (atleta, squadra),
    FOREIGN KEY (atleta) REFERENCES Atleta(utente) ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (squadra) REFERENCES Squadra(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Staff (
    allenatore INT UNSIGNED,
    squadra INT UNSIGNED,
    PRIMARY KEY (allenatore, squadra),
    FOREIGN KEY (allenatore) REFERENCES Allenatore(utente) ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (squadra) REFERENCES Squadra(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Evento (
    data_ora_inizio DATETIME,
    squadra INT UNSIGNED,
    nome VARCHAR(30) NOT NULL,
    descrizione TEXT,
    data_ora_fine DATETIME,
    citta VARCHAR(30) NOT NULL,
    via VARCHAR(50) NOT NULL,
    civico SMALLINT,
    annullato BOOLEAN NOT NULL DEFAULT FALSE,
    motivazione VARCHAR(120),
    accompagnatore INT UNSIGNED,
    PRIMARY KEY (data_ora_inizio, squadra),
    FOREIGN KEY (squadra) REFERENCES Squadra(id) ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (accompagnatore) REFERENCES Dirigente(utente) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT inizio_e_fine CHECK(data_ora_inizio < data_ora_fine)
);

CREATE TABLE IF NOT EXISTS Invito (
    atleta INT UNSIGNED,
    squadra_ev INT UNSIGNED,
    data_ev DATETIME,
    presenza BOOLEAN,
    motivazione VARCHAR(120),
    PRIMARY KEY (atleta, squadra_ev, data_ev),
    FOREIGN KEY (atleta) REFERENCES Atleta(utente) ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (squadra_ev, data_ev) REFERENCES Evento(squadra, data_ora_inizio) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Amministrazione (
    allenatore INT UNSIGNED,
    squadra_ev INT UNSIGNED,
    data_ev DATETIME,
    PRIMARY KEY (allenatore, squadra_ev, data_ev),
    FOREIGN KEY (allenatore) REFERENCES Allenatore(utente) ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (squadra_ev, data_ev) REFERENCES Evento(squadra, data_ora_inizio) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Allenamento (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    data_ora_inizio DATETIME NOT NULL,
    ora_fine TIME,
    stato ENUM('PROGRAMMATO', 'ANNULLATO', 'SVOLTO') NOT NULL DEFAULT 'PROGRAMMATO',
    citta VARCHAR(30),
    via VARCHAR(50),
    civico SMALLINT,
    motivazione VARCHAR(120),
    stagione SMALLINT UNSIGNED,
    CONSTRAINT inizio_fine CHECK(TIME(data_ora_inizio) < ora_fine),
    FOREIGN KEY (stagione) REFERENCES Stagione(anno_inizio) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Partecipazione (
    squadra INT UNSIGNED,
    allenamento INT UNSIGNED,
    PRIMARY KEY (allenamento, squadra),
    FOREIGN KEY (allenamento) REFERENCES Allenamento(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (squadra) REFERENCES Squadra(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Direzione (
    allenatore INT UNSIGNED,
    allenamento INT UNSIGNED,
    PRIMARY KEY (allenamento, allenatore),
    FOREIGN KEY (allenamento) REFERENCES Allenamento(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (allenatore) REFERENCES Allenatore(utente) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Presenza (
    atleta INT UNSIGNED,
    allenamento INT UNSIGNED,
    PRIMARY KEY (allenamento, atleta),
    FOREIGN KEY (allenamento) REFERENCES Allenamento(id) ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (atleta) REFERENCES Atleta(utente) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Report (
    allenamento INT UNSIGNED PRIMARY KEY,
    autore INT UNSIGNED NOT NULL,
    valutazione INT NOT NULL CHECK(valutazione > 0 AND valutazione <= 10),
    note TEXT,
    FOREIGN KEY (allenamento) REFERENCES Allenamento(id) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Etichetta (
    testo VARCHAR(30) PRIMARY KEY CHECK(testo REGEXP '[A-Za-z0-9]')
);

CREATE TABLE IF NOT EXISTS Obiettivo (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    squadra INT UNSIGNED NOT NULL,
    raggiunto BOOLEAN NOT NULL,
    descrizione TEXT NOT NULL,
    scadenza DATE,
    FOREIGN KEY (squadra) REFERENCES Squadra(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS ClassificazioneObiettivo (
    obiettivo INT UNSIGNED,
    etichetta VARCHAR(30),
    PRIMARY KEY (obiettivo, etichetta),
    FOREIGN KEY (obiettivo) REFERENCES Obiettivo(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (etichetta) REFERENCES Etichetta(testo) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Scopo (
    obiettivo INT UNSIGNED,
    allenamento INT UNSIGNED,
    PRIMARY KEY (obiettivo, allenamento),
    FOREIGN KEY (obiettivo) REFERENCES Obiettivo(id) ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (allenamento) REFERENCES Allenamento(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Domanda (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    testo VARCHAR(200) UNIQUE
);

CREATE TABLE IF NOT EXISTS ClassificazioneDomanda (
    domanda INT UNSIGNED,
    etichetta VARCHAR(30),
    PRIMARY KEY (domanda, etichetta),
    FOREIGN KEY (domanda) REFERENCES Domanda(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (etichetta) REFERENCES Etichetta(testo) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Composizione (
    domanda INT UNSIGNED,
    report INT UNSIGNED,
    valutazione INT NOT NULL CHECK(valutazione > 0 AND valutazione <= 10),
    PRIMARY KEY (domanda, report),
    FOREIGN KEY (domanda) REFERENCES Domanda(id) ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (report) REFERENCES Report(allenamento) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Esercizio (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE,
    descrizione TEXT NOT NULL,
    n_partecipanti TINYINT UNSIGNED,
    link_video VARCHAR(200)
);

CREATE TABLE IF NOT EXISTS Eseguibilità (
    categoria VARCHAR(4),
    esercizio INT UNSIGNED,
    PRIMARY KEY (categoria, esercizio),
    FOREIGN KEY (categoria) REFERENCES Categoria(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (esercizio) REFERENCES Esercizio(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS ClassificazioneEsercizio (
    esercizio INT UNSIGNED,
    etichetta VARCHAR(30),
    PRIMARY KEY (esercizio, etichetta),
    FOREIGN KEY (esercizio) REFERENCES Esercizio(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (etichetta) REFERENCES Etichetta(testo) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Programmazione (
    esercizio INT UNSIGNED,
    allenamento INT UNSIGNED,
    PRIMARY KEY (esercizio, allenamento),
    FOREIGN KEY (esercizio) REFERENCES Esercizio(id) ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (allenamento) REFERENCES Allenamento(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Svolgimento (
    esercizio INT UNSIGNED,
    allenamento INT UNSIGNED,
    PRIMARY KEY (esercizio, allenamento),
    FOREIGN KEY (esercizio) REFERENCES Esercizio(id) ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (allenamento) REFERENCES Allenamento(id) ON DELETE CASCADE ON UPDATE CASCADE
);

--
--  DEFINIZIONE TRIGGER
--

CREATE FUNCTION IF NOT EXISTS getUserAge(user_id INT) RETURNS INT
BEGIN
    RETURN (
        SELECT TIMESTAMPDIFF(YEAR, data_nascita, CURRENT_DATE())
        FROM Utente
        WHERE id = user_id -- restituirà un solo utente
    );
END;

-- VINCOLO 1
CREATE TRIGGER IF NOT EXISTS atleta_minorenne
BEFORE INSERT ON Rosa
FOR EACH ROW
BEGIN
    IF getUserAge(NEW.atleta) < 18 AND NOT EXISTS (
        SELECT *
        FROM Tutela 
        WHERE atleta = NEW.atleta
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Un atleta deve essere maggiorenne o avere dei tutori per poter far parte di una rosa";
    END IF;
END;

-- VINCOLO 2
CREATE TRIGGER IF NOT EXISTS tutore_maggiorenne
BEFORE INSERT ON Tutore
FOR EACH ROW
BEGIN
    IF getUserAge(NEW.utente) < 18 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Un tutore deve essere maggiorenne";
    END IF;
END;

CREATE TRIGGER IF NOT EXISTS allenatore_maggiorenne
BEFORE INSERT ON Allenatore
FOR EACH ROW
BEGIN
    IF getUserAge(NEW.utente) < 18 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Un allenatore deve essere maggiorenne";
    END IF;
END;

CREATE TRIGGER IF NOT EXISTS dirigente_maggiorenne
BEFORE INSERT ON Dirigente
FOR EACH ROW
BEGIN
    IF getUserAge(NEW.utente) < 18 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Un dirigente deve essere maggiorenne";
    END IF;
END;


--
--  DEFINIZIONE STORED PROCEDURE
--
