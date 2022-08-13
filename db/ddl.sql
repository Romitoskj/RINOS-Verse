CREATE TABLE IF NOT EXISTS Sesso (
    value CHAR(1) PRIMARY KEY
);

INSERT INTO Sesso (value)
VALUES  ('M'),
        ('F');


CREATE TABLE IF NOT EXISTS Utente (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(30) NOT NULL UNIQUE,
    password CHAR(60) NOT NULL,
    -- output length of the implemented hash function
    cognome VARCHAR(30) NOT NULL,
    nome VARCHAR(30) NOT NULL,
    data_nascita DATE NOT NULL,
    sesso CHAR(1) NOT NULL,
    email VARCHAR(50) UNIQUE,
    telefono VARCHAR(15) UNIQUE,
    FOREIGN KEY (sesso) REFERENCES Sesso(value) ON DELETE NO ACTION ON UPDATE NO ACTION
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
