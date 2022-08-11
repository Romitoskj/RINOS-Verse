CREATE TABLE IF NOT EXISTS Utente (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(30) NOT NULL,
    password CHAR(60) NOT NULL,
    -- output length of the implemented hash function
    cognome VARCHAR(30) NOT NULL,
    nome VARCHAR(30) NOT NULL,
    data_nascita DATE NOT NULL,
    sesso ENUM('M', 'F') NOT NULL,
    email VARCHAR(50),
    telefono VARCHAR(15)
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
    FOREIGN KEY (ruolo) REFERENCES Ruolo(nome) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Tutela (
    atleta INT UNSIGNED,
    tutore INT UNSIGNED,
    PRIMARY KEY (atleta, tutore),
    FOREIGN KEY (atleta) REFERENCES Atleta(utente) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (tutore) REFERENCES Tutore(utente) ON DELETE CASCADE ON UPDATE CASCADE
);


