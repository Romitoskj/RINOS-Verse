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
    tessera INT UNSIGNED UNIQUE,
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
    anno_min SMALLINT UNSIGNED,
    anno_max SMALLINT UNSIGNED,
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
    stagione SMALLINT UNSIGNED NOT NULL,
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
    valutazione INT NOT NULL CHECK(valutazione >= 0 AND valutazione <= 10),
    note TEXT,
    FOREIGN KEY (allenamento) REFERENCES Allenamento(id) ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (autore) REFERENCES Allenatore(utente) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Etichetta (
    testo VARCHAR(30) PRIMARY KEY CHECK(testo REGEXP '[A-Za-z0-9]')
);

CREATE TABLE IF NOT EXISTS Obiettivo (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    squadra INT UNSIGNED NOT NULL,
    raggiunto BOOLEAN NOT NULL,
    descrizione TEXT,
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
    testo VARCHAR(200) UNIQUE NOT NULL
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

CREATE TABLE IF NOT EXISTS Eseguibilita (
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
--  DEFINIZIONE STORED PROCEDURE
--

CREATE FUNCTION IF NOT EXISTS getUserAge(user_id INT) RETURNS INT
BEGIN
    RETURN (
        SELECT TIMESTAMPDIFF(YEAR, data_nascita, CURRENT_DATE())
        FROM Utente
        WHERE id = user_id
    );
END;

--
--  DEFINIZIONE TRIGGER
--

-- VINCOLO 1
-- Un atleta minorenne deve avere almeno un tutore per poter partecipare ad una
-- squadra.

CREATE TRIGGER IF NOT EXISTS atleta_minorenne
BEFORE INSERT ON Rosa
FOR EACH ROW
BEGIN
-- l'implementazione di getUserAge viene riportata nella sezione 'Stored procedure'
    IF getUserAge(NEW.atleta) < 18 AND NOT EXISTS (
        SELECT *
        FROM Tutela 
        WHERE atleta = NEW.atleta
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Un atleta deve essere maggiorenne o avere dei tutori per poter far parte di una rosa";
    END IF;
END;

-- VINCOLO 2
-- Tutori, allenatori e dirigenti devono essere maggiorenni.

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

-- VINCOLO 3
-- Un atleta può far parte di una squadra solo se il suo anno di nascita è
-- compreso tra l’anno di nascita minimo e il massimo definito dalla squadra e
-- il suo sesso è ammesso dalla categoria di cui la squadra fa parte.

CREATE TRIGGER IF NOT EXISTS eta_sesso_atleta
BEFORE INSERT ON Rosa
FOR EACH ROW
BEGIN
    DECLARE anno_nascita INT;
    DECLARE sesso CHAR(1);

    SET anno_nascita = (SELECT YEAR(data_nascita) FROM Utente WHERE id = NEW.atleta);
    SET sesso = (SELECT U.sesso FROM Utente AS U WHERE id = NEW.atleta);

    IF anno_nascita > (SELECT anno_max FROM Squadra WHERE id = NEW.squadra)
        OR anno_nascita < (SELECT anno_min FROM Squadra WHERE id = NEW.squadra) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'età dell'atleta non è adatta alla squadra";
    END IF;

    IF sesso <> (
        SELECT C.sesso
        FROM Categoria AS C JOIN Squadra AS S ON C.id = S.categoria
        WHERE S.id = NEW.squadra
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Il sesso dell'atleta non è accettato dalla categoria";
    END IF;
END;

-- VINCOLO 4
-- In un qualsiasi istante deve esserci al più una stagione in corso.

CREATE TRIGGER IF NOT EXISTS insert_stagione_corrente
BEFORE INSERT ON Stagione
FOR EACH ROW
BEGIN
    IF NEW.corrente = 1 AND EXISTS (SELECT * FROM stagione WHERE corrente = 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "C'è già una stagione in corso";
    END IF;
END;

CREATE TRIGGER IF NOT EXISTS update_stagione_corrente
BEFORE UPDATE ON Stagione
FOR EACH ROW
BEGIN
    IF NEW.corrente = 1 AND EXISTS (SELECT * FROM stagione WHERE corrente = 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "C'è già una stagione in corso";
    END IF;
END;

-- VINCOLO 5
-- I nuovi eventi inseriti devono avere una data e ora di inizio successiva
-- rispetto a quella in cui viene effettuato l’inserimento, non possono essere
-- inseriti come annullati, devono far parte del calendario della stagione
-- corrente e le squadre a cui afferiscono devono essere attive in questa stagione.

CREATE TRIGGER IF NOT EXISTS nuovo_evento
BEFORE INSERT ON Evento
FOR EACH ROW
BEGIN
    IF NEW.data_ora_inizio <= NOW() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "La data selezionata non è corretta";
    END IF;

    IF NEW.annullato IS TRUE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'evento non può essere inserito come annullato";
    END IF;

    IF (
        SELECT corrente 
        FROM Squadra JOIN Stagione ON stagione = anno_inizio
        WHERE id = NEW.squadra
    ) IS FALSE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "La squadra non è attiva nella stagione corrente";
    END IF;
END;

-- VINCOLO 6
-- I nuovi allenamenti inseriti devono essere nello stato “programmato” (non
-- “annullato” o “svolto”),  avere una data e ora di inizio successiva rispetto
-- a quella in cui viene effettuato l’inserimento e devono far parte del
-- calendario della stagione corrente.

CREATE TRIGGER IF NOT EXISTS nuovo_allenamento
BEFORE INSERT ON Allenamento
FOR EACH ROW
BEGIN
    IF NEW.data_ora_inizio <= NOW() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "La data selezionata non è corretta";
    END IF;

    IF NEW.stato <> 'PROGRAMMATO' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'allenamento non può essere inserito come annullato o svolto";
    END IF;

    IF (
        SELECT corrente 
        FROM Stagione
        WHERE anno_inizio = NEW.stagione
    ) IS FALSE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'allenamento deve far parte del calendario della stagione in corso";
    END IF;
END;

-- VINCOLO 7
-- Gli atleti invitati ad un evento devono far parte della rosa della squadra a
-- cui l'evento afferisce.

CREATE TRIGGER IF NOT EXISTS invito_evento
BEFORE INSERT ON invito
FOR EACH ROW
BEGIN
    IF NEW.atleta NOT IN (
        SELECT atleta
        FROM rosa
        WHERE squadra = NEW.squadra_ev
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'atleta deve far parte della squadra a cui l'evento afferisce";
    END IF;
END;

-- VINCOLO 8
-- Gli atleti presenti ad un allenamento devono far parte della rosa di almeno
-- una delle squadre che vi partecipano.

CREATE TRIGGER IF NOT EXISTS presenza_allenamento
BEFORE INSERT ON presenza
FOR EACH ROW
BEGIN
    IF NEW.atleta NOT IN (
        SELECT R.atleta
        FROM Rosa AS R JOIN Partecipazione AS P ON R.squadra = P.squadra
        WHERE P.allenamento = NEW.allenamento
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'atleta deve far parte di una delle squadre che partecipano all'allenamento";
    END IF;
END;

-- VINCOLO 9
-- Un report deve recensire un allenamento nello stato “svolto” (non
-- “programmato” o “annullato”) e il suo autore deve essere uno degli allenatori
-- che l’hanno diretto.

CREATE TRIGGER IF NOT EXISTS recensione_allenamento
BEFORE INSERT ON Report
FOR EACH ROW
BEGIN
    IF 'SVOLTO' <> (SELECT stato FROM Allenamento WHERE id = NEW.allenamento) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Si possono recensire solo allenamenti svolti";
    END IF;
    
    IF NEW.autore NOT IN (
        SELECT allenatore
        FROM Direzione 
        WHERE allenamento = NEW.allenamento
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'autore della recensione deve aver diretto il relativo allenamento";
    END IF;
END;

-- VINCOLO 10
-- Gli scopi di un allenamento devono essere selezionati tra gli obiettivi
-- attivi (ossia non ancora raggiunti) delle squadre che parteciperanno
-- all'allenamento.

CREATE TRIGGER IF NOT EXISTS scopo_allenamento
BEFORE INSERT ON Scopo
FOR EACH ROW
BEGIN
    IF (SELECT raggiunto FROM Obiettivo WHERE id = NEW.obiettivo) IS TRUE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'obiettivo è già stato raggiunto";
    END IF;

    IF NEW.obiettivo NOT IN (
        SELECT id
        FROM Obiettivo
        WHERE squadra IN (
            SELECT squadra
            FROM Partecipazione
            WHERE allenamento = NEW.allenamento
        )
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'obbiettivo non è assegnato ad una squadra che partecipa all'allenamento";
    END IF;
END;

-- VINCOLO 11
-- Le squadre che partecipano ad un allenamento devono essere squadre in
-- attività durante la stagione in cui l’allenamento ha luogo.

CREATE TRIGGER IF NOT EXISTS partecipazione_allenamento
BEFORE INSERT ON Partecipazione
FOR EACH ROW
BEGIN
    IF (
        SELECT stagione
        FROM Squadra
        WHERE id = NEW.squadra
    ) <> (
        SELECT stagione
        FROM Allenamento
        WHERE id = NEW.allenamento
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "La squadra deve essere attiva nella stagione in cui si svolge l'allenamento";
    END IF;
END;

-- VINCOLO 12
-- L'anno di nascita minimo e massimo dei componenti di una squadra si ottiene
-- sottraendo all'anno di inizio della stagione in cui essa è attiva l'età
-- minima e l'età massima della categoria di cui la squadra fa parte.

CREATE TRIGGER IF NOT EXISTS anno_max_e_min_squadra
BEFORE INSERT ON Squadra
FOR EACH ROW
BEGIN
    SET NEW.anno_min = NEW.stagione - (SELECT eta_max FROM Categoria WHERE id = NEW.categoria);
    SET NEW.anno_max = NEW.stagione - (SELECT eta_min FROM Categoria WHERE id = NEW.categoria);
END;

-- VINCOLO 13
-- Un allenamento per essere contrassegnato come svolto deve avere almeno un
-- allenatore che lo ha diretto, un atleta presente e un esercizio svolto.
-- Inoltre non può essere contrassegnato come svolto se è stato annullato.

CREATE TRIGGER IF NOT EXISTS allenamento_svolto
BEFORE UPDATE ON Allenamento
FOR EACH ROW
BEGIN
    IF NEW.stato = 'SVOLTO' THEN
        IF OLD.stato = 'ANNULLATO' THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Impossibile svolgere un allenamento annullato";
        ELSEIF NOT EXISTS (SELECT * FROM Direzione WHERE allenamento = NEW.id) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'allenamento non ha nessun allenatore che l'ha diretto";
        ELSEIF NOT EXISTS (SELECT * FROM Presenza WHERE allenamento = NEW.id) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'allenamento non ha nessun atleta presente";
        ELSEIF NOT EXISTS (SELECT * FROM Svolgimento WHERE allenamento = NEW.id) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'allenamento non ha nessun esercizio svolto";
        END IF;
    END IF;
END;

-- VINCOLO 14
-- Le categorie del rugby devono avere il sesso degli atleti ammessi indicato,
-- mentre quelle del minirugby devono non lo devono indicare.

CREATE TRIGGER IF NOT EXISTS sesso_categoria
BEFORE INSERT ON Categoria
FOR EACH ROW
BEGIN
    IF NEW.tipo = 'RUGBY' AND NEW.sesso IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Bisogna specificare il sesso degli atleti";
    END IF;

    IF NEW.tipo = 'MINIRUGBY' AND NEW.sesso IS NOT NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Il sesso degli atleti non deve essere specificato";
    END IF;
END;
