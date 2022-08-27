/*  

NOTA: tutte le operazioni che richiedono dei dati specifici, ad esempio l'id di
un atleta, dipenderanno dal contenuto di variabili utilizzate nell'applicazione
finale.
    
Pertanto i valori usati nelle interrogazioni sono da interpretare come placeholder.

*/


-- OPERAZIONE 1
-- Visualizzazione dei contatti di un atleta e, se ne ha, anche quelli dei suoi
-- tutori.

SELECT ATL.ID AS atleta, ATL.nome, ATL.cognome, ATL.email, ATL.telefono,
    tutore, TUT.nome AS nome_tutore, TUT.cognome AS cognome_tutore,
    TUT.email AS email_tutore, TUT.telefono AS telefono_tutore
FROM Utente AS ATL
JOIN Atleta ON ATL.id = utente
LEFT JOIN Tutela ON atleta = ATL.id
LEFT JOIN Utente AS TUT ON TUT.id = tutore
WHERE ATL.id = 3;

-- SI DEFINISCE UNA VISTA CHE ESTRAE I CONTATTI DI TUTTI GLI ATLETI E RELATIVI
-- TUTORI PER FACILITARE L'OPERAZIONE 4

CREATE OR REPLACE VIEW contatti_atleti_tutori AS
SELECT ATL.ID AS atleta, ATL.nome, ATL.cognome, ATL.email, ATL.telefono,
    tutore, TUT.nome AS nome_tutore, TUT.cognome AS cognome_tutore,
    TUT.email AS email_tutore, TUT.telefono AS telefono_tutore
FROM Utente AS ATL
JOIN Atleta ON ATL.id = utente
LEFT JOIN Tutela ON atleta = ATL.id
LEFT JOIN Utente AS TUT ON TUT.id = tutore;

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

CREATE OR REPLACE VIEW numero_allenamenti_svolti_squadre AS
SELECT squadra, COUNT(*) AS numero
FROM Partecipazione
JOIN Allenamento ON allenamento = id
WHERE stato = 'SVOLTO'
GROUP BY squadra;

SELECT U.username,
    COUNT(*) / (
        SELECT numero
        FROM numero_allenamenti_svolti_squadre
        WHERE squadra = 2
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

-- OPERAZIONE 3
-- Visualizzazione del numero totale degli atleti invitati, il numero degli
-- atleti che saranno presenti, quelli assenti e coloro che non hanno ancora
-- risposto all'invito per ogni evento futuro amministrato da uno specifico
-- allenatore.

SELECT E.nome AS evento,
    E.squadra AS squadra,
    E.data_ora_inizio AS data_ora,
    COUNT(*) AS totale,
    SUM(CASE WHEN I.presenza THEN 1 ELSE 0 END) AS presenti,
    SUM(CASE WHEN NOT I.presenza THEN 1 ELSE 0 END) AS assenti,
    SUM(CASE WHEN I.presenza IS NULL THEN 1 ELSE 0 END) AS senza_risposta
FROM Invito AS I
JOIN Evento AS E ON I.squadra_ev = E.squadra AND I.data_ev = E.data_ora_inizio
JOIN Amministrazione AS A ON A.squadra_ev = E.squadra AND A.data_ev = E.data_ora_inizio
WHERE E.data_ora_inizio > NOW() AND A.allenatore = 22 AND E.annullato IS FALSE
GROUP BY E.squadra, E.data_ora_inizio
ORDER BY E.data_ora_inizio;

-- OPERAZIONE 4 (utilizza la vista definita nella operazione 1)
-- Visualizzazione dei contatti degli atleti che non hanno intenzione di
-- partecipare ad un evento futuro, o che non hanno risposto all'invito.

SELECT *
FROM contatti_atleti_tutori
WHERE atleta IN (
    SELECT atleta
    FROM Invito
    WHERE squadra_ev = 2 AND data_ev = '2022-09-11 11:30:00'
        AND (NOT presenza OR presenza IS NULL)
);

-- OPERAZIONE 4 CON ULTERIORE VISTA

CREATE OR REPLACE VIEW inviti_senza_risposta_o_assenti AS
SELECT *
FROM Invito
WHERE NOT presenza OR presenza IS NULL;

SELECT *
FROM contatti_atleti_tutori
WHERE atleta IN (
    SELECT atleta
    FROM inviti_senza_risposta_o_assenti
    WHERE squadra_ev = 2 AND data_ev = '2022-09-11 11:30:00'
);

-- OPERAZIONE 5
-- Calcolo della qualità media degli allenamenti delle squadre sulla base delle
-- valutazioni generali.

SELECT squadra, AVG(valutazione) AS qualità_media
FROM Report AS R
JOIN Partecipazione AS P ON P.allenamento = R.allenamento
GROUP BY squadra;

-- OPERAZIONE 6
-- Visualizzazione delle possibili squadre a cui gli atleti possono partecipare,
-- per facilitare l’inserimento degli atleti nelle varie rose (considerando che
-- gli atleti minorenni possono partecipare ad una squadra solo se hanno almeno
-- un tutore).

SELECT U.id AS atleta, S.id AS squadra
FROM Utente AS U
JOIN Atleta AS A ON A.utente = U.id
JOIN Squadra AS S ON YEAR(U.data_nascita) BETWEEN S.anno_min AND S.anno_max
JOIN Categoria AS C ON S.categoria = C.id AND (U.sesso = C.sesso OR C.sesso IS NULL)
WHERE S.stagione = (SELECT anno_inizio FROM Stagione WHERE corrente IS TRUE)
AND (getUserAge(U.id) >= 18 OR EXISTS (
    SELECT *
    FROM Tutela
    WHERE atleta = U.id
));

-- OPERAZIONE 7
-- Visualizzazione dei prossimi allenamenti in programma e le relative squadre
-- partecipanti.

SELECT S.id AS squadra, A.*
FROM Squadra AS S
JOIN Partecipazione AS P ON P.squadra = S.id
JOIN Allenamento AS A ON A.id = P.allenamento
WHERE A.data_ora_inizio > NOW() AND A.stato = 'PROGRAMMATO';

-- OPERAZIONE 8
-- Visualizzazione degli allenamenti che gli atleti tutelati da un dato tutore
-- hanno in programma.

-- si utilizza l'operazione precedente come vista

CREATE OR REPLACE VIEW allenamenti_programmati_squadre AS
SELECT S.id AS squadra, A.*
FROM Squadra AS S
JOIN Partecipazione AS P ON P.squadra = S.id
JOIN Allenamento AS A ON A.id = P.allenamento
WHERE A.data_ora_inizio > NOW() AND A.stato = 'PROGRAMMATO';

SELECT U.id AS id_atleta, U.nome AS atleta, APS.id AS id_allenamento,
    APS.data_ora_inizio AS data_e_ora
FROM allenamenti_programmati_squadre AS APS 
JOIN Rosa AS R ON R.squadra = APS.squadra
JOIN Utente AS U ON U.id = R.atleta
JOIN Tutela AS T ON T.atleta = R.atleta
WHERE T.tutore = 9
ORDER BY APS.data_ora_inizio;

-- OPERAZIONE 9
-- Visualizzazione degli esercizi consigliati dato un allenamento con squadre
-- partecipanti e degli scopi inseriti, in modo da facilitare la programmazione
-- di un allenamento.

SELECT DISTINCT E.*
FROM Esercizio AS E
JOIN ClassificazioneEsercizio AS CE ON CE.esercizio = E.id
JOIN Eseguibilita AS ES ON ES.esercizio = E.id
WHERE EXISTS (
    SELECT *
    FROM Scopo AS S
    JOIN ClassificazioneObiettivo AS CO ON CO.obiettivo = S.obiettivo
    JOIN Partecipazione AS P ON P.allenamento = S.allenamento
    JOIN Squadra AS Sq ON Sq.id = P.squadra
    WHERE S.allenamento = 22
        AND CO.etichetta = CE.etichetta
        AND Sq.categoria = ES.categoria
);

-- OPERAZIONE 10
-- Visualizzazione delle domande a cui è possibile rispondere in un report a
-- seconda degli esercizi svolti durante il relativo allenamento, ordinandole
-- poi per rilevanza (ossia più una domanda ha etichette in comune con gli
-- esercizi prima apparirà).

SELECT D.*
FROM Svolgimento AS S
JOIN ClassificazioneEsercizio AS CE ON CE.esercizio = S.esercizio
JOIN ClassificazioneDomanda AS CD ON CD.etichetta = CE.etichetta
JOIN Domanda AS D ON D.id = CD.domanda
WHERE S.allenamento = 21
GROUP BY domanda
ORDER BY COUNT(*) DESC;


-- OPERAZIONE 11
-- Calcolo dell’incremento (o decremento) della qualità degli allenamenti in un
-- dato mese rispetto ad un qualsiasi mese precedente, per tutte squadre attive 
-- nella stagione in corso.

SELECT LUGLIO.squadra,
    LUGLIO.valutazione_media - IFNULL(GIUGNO.valutazione_media, 0) AS incremento_qualità
FROM (
    SELECT squadra,
        MONTH(data_ora_inizio) AS mese,
        AVG(valutazione) AS valutazione_media
    FROM Report AS R
    JOIN Partecipazione AS P ON P.allenamento = R.allenamento
    JOIN Allenamento AS A ON A.id = R.allenamento
    JOIN Squadra AS S ON S.id = P.squadra
    WHERE S.stagione = (
        SELECT anno_inizio
        FROM Stagione
        WHERE corrente IS TRUE
    )
    GROUP BY squadra, MONTH(data_ora_inizio)
    HAVING mese = 7
) AS LUGLIO
LEFT JOIN (
    SELECT squadra,
        MONTH(data_ora_inizio) AS mese,
        AVG(valutazione) AS valutazione_media
    FROM Report AS R
    JOIN Partecipazione AS P ON P.allenamento = R.allenamento
    JOIN Allenamento AS A ON A.id = R.allenamento
    JOIN Squadra AS S ON S.id = P.squadra
    WHERE S.stagione = (
        SELECT anno_inizio
        FROM Stagione
        WHERE corrente IS TRUE
    )
    GROUP BY squadra, MONTH(data_ora_inizio)
    HAVING mese = 6
) AS GIUGNO ON GIUGNO.squadra = LUGLIO.squadra;

-- OPERAZIONE 11 CON LE VISTE

CREATE OR REPLACE VIEW valutazioni_medie_squadre_per_mese AS
SELECT squadra,
    MONTH(data_ora_inizio) AS mese,
    AVG(valutazione) AS valutazione_media
FROM Report AS R
JOIN Partecipazione AS P ON P.allenamento = R.allenamento
JOIN Allenamento AS A ON A.id = R.allenamento
JOIN Squadra AS S ON S.id = P.squadra
WHERE S.stagione = (
    SELECT anno_inizio
    FROM Stagione
    WHERE corrente IS TRUE
)
GROUP BY squadra, MONTH(data_ora_inizio);

SELECT LUGLIO.squadra,
    LUGLIO.valutazione_media - IFNULL(GIUGNO.valutazione_media, 0) AS incremento_qualità
FROM (
    SELECT *
    FROM valutazioni_medie_squadre_per_mese
    WHERE mese = 7
) AS LUGLIO
LEFT JOIN (
    SELECT *
    FROM valutazioni_medie_squadre_per_mese
    WHERE mese = 6
) AS GIUGNO ON GIUGNO.squadra = LUGLIO.squadra;

-- OPERAZIONE 12
-- Selezionamento della domanda che ha ricevuto più risposte per ogni etichetta.

SELECT CD.etichetta, D.testo, COUNT(*) AS numero_risposte
FROM Domanda AS D
JOIN ClassificazioneDomanda AS CD ON CD.domanda = D.id
JOIN Composizione AS C ON C.domanda = D.id
GROUP BY CD.etichetta, D.id
HAVING (CD.etichetta, numero_risposte) IN (
    SELECT etichetta, MAX(numero_risposte) AS max_numero_risposte
    FROM (
        SELECT CD.etichetta, D.testo, COUNT(*) AS numero_risposte
        FROM Domanda AS D
        JOIN ClassificazioneDomanda AS CD ON CD.domanda = D.id
        JOIN Composizione AS C ON C.domanda = D.id
        GROUP BY CD.etichetta, D.id
    ) AS domande_numero_risposte
    GROUP BY etichetta
);

-- OPERAZIONE 12 CON LE VISTE

CREATE OR REPLACE VIEW domande_numero_risposte AS
SELECT CD.etichetta, D.testo, COUNT(*) AS numero_risposte
FROM Domanda AS D
JOIN ClassificazioneDomanda AS CD ON CD.domanda = D.id
JOIN Composizione AS C ON C.domanda = D.id
GROUP BY CD.etichetta, D.id;

SELECT *
FROM domande_numero_risposte
HAVING (etichetta, numero_risposte) IN (
    SELECT etichetta, MAX(numero_risposte) AS max_numero_risposte
    FROM domande_numero_risposte
    GROUP BY etichetta
);

-- OPERAZIONE 13
-- Visualizzazione del calendario degli allenamenti e degli eventi in programma
-- nel successivo mese a cui un atleta può partecipare.

SELECT nome, squadra, data_ora_inizio, id_allenamento
FROM (
    SELECT squadra, 'Allenamento' AS nome, data_ora_inizio, id AS id_allenamento
    FROM Allenamento JOIN Partecipazione ON allenamento = id
    WHERE stato = 'PROGRAMMATO'
    UNION
    SELECT squadra, nome, data_ora_inizio, NULL AS id_allenamento
    FROM Evento
    WHERE annullato IS FALSE
) AS Calendario
WHERE data_ora_inizio BETWEEN NOW() AND DATE_ADD(NOW(), INTERVAL 1 MONTH)
AND squadra IN (
    SELECT squadra
    FROM Rosa AS R
    WHERE atleta = 24
)
ORDER BY data_ora_inizio;

-- OPERAZIONE 13 CON LE VISTE

CREATE OR REPLACE VIEW Calendario AS
SELECT squadra, 'Allenamento' AS nome, data_ora_inizio, id AS id_allenamento
FROM Allenamento JOIN Partecipazione ON allenamento = id
WHERE stato = 'PROGRAMMATO'
UNION
SELECT squadra, nome, data_ora_inizio, NULL AS id_allenamento
FROM Evento
WHERE annullato IS FALSE;

SELECT nome, squadra, data_ora_inizio, id_allenamento
FROM Calendario
WHERE data_ora_inizio BETWEEN NOW() AND DATE_ADD(NOW(), INTERVAL 1 MONTH)
AND squadra IN (
    SELECT squadra
    FROM Rosa AS R
    WHERE atleta = 24
)
ORDER BY data_ora_inizio;
