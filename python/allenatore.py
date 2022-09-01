from msilib import sequence
from msilib.schema import Error
import mariadb
from colorama import Fore, Back, Style

class Allenatore:

    def __init__(self, id):
        self.id = id

    def signin(cur, id):
        cur.execute(
            "INSERT INTO allenatore VALUES (?)",
            (id,)
        )
        return Allenatore(id)

    def squadre(self, cur):
        cur.execute(
            """
            SELECT S.id, C.nome
            FROM Squadra AS S
            JOIN Staff AS ST ON ST.squadra = S.id
            JOIN Categoria AS C ON C.id = S.categoria
            WHERE ST.allenatore = ?
            AND S.stagione = (SELECT anno_inizio FROM Stagione WHERE corrente IS TRUE);
            """, (self.id,)
        )
        res = cur.fetchall()
        if res:
            return dict(res)
        else: return {}

    def presenze(self, cur, squadra):
        cur.execute(
            """
            SELECT U.username, U.nome, U.cognome,
                COUNT(*) / (
                    SELECT numero
                    FROM numero_allenamenti_svolti_squadre
                    WHERE squadra = ?
                ) * 100 AS percentuale
            FROM Presenza AS P
            JOIN Utente AS U ON P.atleta = U.id
            JOIN Allenamento AS A ON P.allenamento = A.id
            WHERE atleta IN (
                SELECT atleta
                FROM Rosa
                WHERE squadra = ?
            ) AND A.stato = 'SVOLTO'
            GROUP BY P.atleta;
            """, (squadra, squadra)
        )
        res = cur.fetchall()

        if res:
            return {x[0]: f"{x[1]} {x[2]}: {x[3]}%" for x in res}
        else:
            return None

    # TODO operazione 3
    def presenze_eventi(self, cur):
        cur.execute(
            """
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
            WHERE E.data_ora_inizio > NOW() AND A.allenatore = ? AND E.annullato IS FALSE
            GROUP BY E.squadra, E.data_ora_inizio
            ORDER BY E.data_ora_inizio;
            """, (self.id,)
        )
        res = cur.fetchall()
        if res:
            return [e[0] + "\t" + e[2].strftime("%d/%m/%Y, %H:%M:%S") + "\ttotale: " + str(e[3]) + "\tpresenti: " + str(e[4]) + "\tassenti: " + str(e[5]) + "\tsenza risposta: " + str(e[6]) for e in res]
        else:
            return None

    def partecipazione_squadra(self, cur, allenamento, squadra):
        try:
            cur.execute(
                """
                INSERT INTO Partecipazione (squadra, allenamento) VALUES
                (?,?)
                """, (squadra, allenamento)
            )
        except mariadb.Error as e:
            print(Fore.RED + "Squadra già inserita" + Style.RESET_ALL)

    def programmazione_es(self, cur, all, es):
        try:
            cur.execute(
                """
                INSERT INTO Programmazione (esercizio, allenamento) VALUES
                (?,?)
                """, (es, all)
            )
        except mariadb.Error as e:
            print(Fore.RED + "Esercizio già inserito." + Style.RESET_ALL)

    def scopo(self, cur, all, scopo):
        try:
            cur.execute(
                """
                INSERT INTO Scopo (obiettivo, allenamento) VALUES
                (?,?)
                """, (scopo, all)
            )
        except mariadb.Error as e:
            print(Fore.RED + "Scopo già inserito" + Style.RESET_ALL)

    def lista_scopi(self, cur, all):
        cur.execute(
            """
            SELECT O.id, O.nome
            FROM Partecipazione AS P
            JOIN Allenamento AS A ON A.id = P.allenamento
            JOIN Obiettivo AS O ON O.squadra = P.squadra
            WHERE A.id = ?;
            """, (all,)
        )
        res = cur.fetchall()

        if res:
            return dict(res)
        else:
            return None

    def lista_es(self, cur, all):
        cur.execute(
            """
            SELECT DISTINCT E.id, E.nome
            FROM Esercizio AS E
            JOIN ClassificazioneEsercizio AS CE ON CE.esercizio = E.id
            JOIN Eseguibilita AS ES ON ES.esercizio = E.id
            WHERE EXISTS (
                SELECT *
                FROM Scopo AS S
                JOIN ClassificazioneObiettivo AS CO ON CO.obiettivo = S.obiettivo
                JOIN Partecipazione AS P ON P.allenamento = S.allenamento
                JOIN Squadra AS Sq ON Sq.id = P.squadra
                WHERE S.allenamento = ?
                    AND CO.etichetta = CE.etichetta
                    AND Sq.categoria = ES.categoria
            );
            """, (all,)
        )
        res = cur.fetchall()

        if res:
            return dict(res)
        else:
            return None


    # TODO programmazione allenamento (con operazione 9)
    def nuovo_allenamento(self, cur, data):
        cur.execute(
            """
            INSERT INTO allenamento(data_ora_inizio, stagione) VALUES
            (?, (SELECT anno_inizio FROM Stagione WHERE corrente IS TRUE))
            """, (data,)
        )
        cur.execute("SELECT MAX(ID) FROM allenamento;")
        all = cur.fetchone()[0]
        squadre = self.squadre(cur)
        while True:
            print()
            print("Seleziona squadre partecipanti:")
            print("\t[0]\tContinua")
            for squadra, categoria in squadre.items():
                print("\t["+ str(squadra) + "]"+ "\t" + categoria)

            choice = int(input(Fore.GREEN + "> " + Style.RESET_ALL))
            if choice == 0: break
            if choice not in squadre.keys():
                print(Fore.RED + "Squadra inesistente." + Style.RESET_ALL)
                continue
            self.partecipazione_squadra(cur, all, choice)
        scopi = self.lista_scopi(cur, all)
        while True:
            print()
            print("Seleziona degli scopi:")
            print("\t[0]\tContinua")
            if scopi:
                for id, ob in scopi.items():
                    print("\t["+ str(id) + "]"+ "\t" + ob)
            else: print("Non ci sono obiettivi selezionabili.")

            choice = int(input(Fore.GREEN + "> " + Style.RESET_ALL))
            if choice == 0: break
            if choice not in scopi.keys():
                print(Fore.RED + "Obiettivo inesistente." + Style.RESET_ALL)
                continue
            self.scopo(cur, all, choice)
        esercizi = self.lista_es(cur, all)
        while True:
            print()
            print("Seleziona degli esercizi:")
            print("\t[0]\tContinua")
            if esercizi:
                for id, es in esercizi.items():
                    print("\t["+ str(id) + "]"+ "\t" + es)
            else: print("Non ci sono esercizi.")

            choice = int(input(Fore.GREEN + "> " + Style.RESET_ALL))
            if choice == 0: break
            if choice not in esercizi.keys():
                print(Fore.RED + "Esercizio inesistente." + Style.RESET_ALL)
                continue
            self.programmazione_es(cur, all, choice)
        print(Fore.GREEN + "Allenamento programmato per il " + data + "!" + Style.RESET_ALL)
        
                
    def menu(self, cur):
        choice = None
        print()
        print(Fore.GREEN + "DASHBOARD ALLENATORE" + Style.RESET_ALL)
        while True:
            print()
            print("[0]\tIndietro")
            print("[1]\tVisualizza le tue squadre")
            print("[2]\tVisualizza le percentuali di presenza agli allenamenti delle tue squadre")
            print("[3]\tVisualizza il calendario degli eventi")
            print("[4]\tProgramma un nuovo allenamento")

            choice = int(input(Fore.GREEN + "> " + Style.RESET_ALL))

            if choice == 1:
                squadre = self.squadre(cur).items()
                if squadre:
                    for _, categoria in squadre:
                        print("\t" + categoria)
                else:
                    print("Non fai parte dello staff di nessuna squadra.")
            elif choice == 2:
                squadre = self.squadre(cur)
                if squadre:
                    while True:
                        print("Scegli la squadra:")
                        print("\t[0]\tIndietro")
                        for id, categoria in squadre.items():
                            print("\t["+ str(id) + "]\t" + categoria)
                        choice = int(input(Fore.GREEN + "> " + Style.RESET_ALL))
                        if choice == 0: break
                        if choice not in squadre.keys():
                            print(Fore.RED + "Squadra inesistente." + Style.RESET_ALL)
                            continue
                        try:
                            presenze = self.presenze(cur, choice)
                            if presenze:
                                for presenza in presenze.values():
                                    print("\t" + presenza)
                            else:
                                print("La squadra non ha ancora svolto allenamenti.")
                        except mariadb.Error as e:
                            print(Fore.RED + str(e) + Style.RESET_ALL)
                else:
                    print("Non fai parte dello staff di nessuna squadra.")
            elif choice ==  3:
                eventi = self.presenze_eventi(cur)
                if eventi:
                    for evento in eventi:
                        print(evento)
                else:
                    print("Non hai eventi in programma.")
            elif choice == 4:
                while True:
                    try:
                        data = input("Inserisci la data e l'ora (YYYY-MM-DD HH:MM:SS): ")
                        self.nuovo_allenamento(cur, data)
                        break
                    except mariadb.Error as e:
                        print(Fore.RED + str(e) + Style.RESET_ALL)
            elif choice == 5:
                pass
            else:
                return