-- OPERAZIONE 1
-- Visualizzazione dei contatti di un atleta e, se ne ha, anche quelli dei suoi
-- tutori.

SELECT nome, cognome, email, telefono
FROM Utente LEFT JOIN Atleta ON id = utente
WHERE utente = 3
    OR id IN (
        SELECT tutore
        FROM Tutela
        WHERE atleta = 3
    );


-- VERSIONE SENZA SUBQUERY
SELECT ATL.nome, ATL.cognome, ATL.email, ATL.telefono, TUT.nome AS nome_tutore,
TUT.cognome AS cognome_tutore, TUT.email AS email_tutore, TUT.telefono AS telefono_tutore
FROM Utente AS ATL
JOIN Atleta ON ATL.id = utente
LEFT JOIN Tutela ON atleta = ATL.id
LEFT JOIN Utente AS TUT ON TUT.id = tutore
WHERE utente = 3;


-- OPERAZIONE 1 CON VISTE

CREATE OR REPLACE VIEW tutori_atleta_3 AS
SELECT tutore
FROM Tutela
WHERE atleta = 3;

SELECT nome, cognome, email, telefono
FROM Utente LEFT JOIN Atleta ON id = utente
WHERE utente = 3
    OR id IN (SELECT * FROM tutori_atleta_3);

-- OPERAZIONE 2
-- Visualizzazione della percentuale di presenza agli allenamenti di ogni atleta
-- facente parte della rosa di una determinata squadra.

SELECT U.username, COUNT(*) / (
    SELECT COUNT(*)
    FROM Partecipazione
    JOIN Allenamento ON allenamento = id
    WHERE squadra = 2
    AND stato = 'SVOLTO'
) * 100 AS percentuale
FROM Presenza AS P
JOIN Utente AS U ON P.atleta = U.id
JOIN Allenamento AS A ON P.allenamento = A.id
WHERE atleta IN (
    SELECT atleta
    FROM Rosa
    WHERE squadra = 2
) AND A.stato = 'SVOLTO'
GROUP BY P.atleta;

-- OPERAZIONE 2 CON VISTE

CREATE OR REPLACE VIEW allenamenti_svolti_squadra_2 AS
SELECT COUNT(*)
FROM Partecipazione
JOIN Allenamento ON allenamento = id
WHERE squadra = 2
AND stato = 'SVOLTO';

SELECT U.username, COUNT(*) / (SELECT * FROM allenamenti_svolti_squadra_2) * 100 AS percentuale
FROM Presenza AS P
JOIN Utente AS U ON P.atleta = U.id
JOIN Allenamento AS A ON P.allenamento = A.id
WHERE atleta IN (
    SELECT atleta
    FROM Rosa
    WHERE squadra = 2
) AND A.stato = 'SVOLTO'
GROUP BY P.atleta;

-- OPERAZIONE 3
-- Visualizzazione del numero totale degli atleti invitati, il numero degli
-- atleti che saranno presenti, quelli assenti e coloro che non hanno ancora
-- risposto all'invito per ogni evento futuro amministrato da uno specifico
-- allenatore.

-- OPERAZIONE 4
-- Visualizzazione dei contatti degli atleti che non hanno intenzione di
-- partecipare ad un evento futuro.

-- OPERAZIONE 5
-- Calcolo della qualità media degli allenamenti di una squadra in base alla
-- valutazione generale.

-- OPERAZIONE 6
-- Visualizzazione delle possibili squadre a cui un atleta può partecipare, per
-- permettere l’inserimento dell’atleta nella rosa di una squadra.

-- OPERAZIONE 7
-- Visualizzazione dei prossimi allenamenti programmati di una squadra.

-- OPERAZIONE 8
-- Visualizzazione degli allenamenti che gli atleti tutelati da un dato tutore
-- hanno in programma.

-- OPERAZIONE 9
-- Visualizzazione degli esercizi consigliati dato un allenamento con squadre
-- partecipanti e degli scopi inseriti, in modo da facilitare la programmazione
-- di un allenamento.

-- OPERAZIONE 10
-- Visualizzazione delle domande a cui è possibile rispondere in un report in
-- base agli esercizi svolti durante l’allenamento.

-- OPERAZIONE 11
-- Calcolo della valutazione media di una squadra per ogni etichetta di cui
-- appaiono domande nei report degli allenamenti.

-- OPERAZIONE 12
-- Calcolo dell’incremento (o decremento) della qualità degli allenamenti di una
-- squadra in un dato mese rispetto al precedente.

-- OPERAZIONE 13
-- Selezionamento della domanda che ha ricevuto più risposte per ogni etichetta.

-- OPERAZIONE 14
-- Visualizzazione degli allenamenti e degli eventi, in programma nel mese in
-- cui viene effettuata la richiesta, a cui un atleta può partecipare ordinati 
-- cronologicamente.
