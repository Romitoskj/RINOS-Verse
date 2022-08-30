import mariadb
from colorama import Fore, Back, Style


class Atleta:

    def __init__(self, id):
        self.id = id

    def signin(cur, id):
        cur.execute(
            "INSERT INTO atleta VALUES (?)",
            (id,)
        )
        return Atleta(id)

    def calendario(self, cur):
        cur.execute(
            """
            SELECT nome, squadra, data_ora_inizio, id_allenamento
            FROM Calendario
            WHERE data_ora_inizio BETWEEN NOW() AND DATE_ADD(NOW(), INTERVAL 1 MONTH)
            AND squadra IN (
                SELECT squadra
                FROM Rosa AS R
                WHERE atleta = ?
            )
            AND (nome = 'Allenamento' OR (squadra, data_ora_inizio) IN (
                SELECT squadra_ev, data_ev
                FROM invito
                WHERE atleta = ?
            ))
            ORDER BY data_ora_inizio;
            """,
            (self.id, self.id)
        )

        res = []
        for nome, squadra, data, allenamento in cur.fetchall():
            res.append({
                'nome': nome,
                'squadra': squadra,
                'data': data.strftime("%d/%m/%Y, %H:%M:%S"),
                'allenamento': allenamento
            })

        return res

    def squadre(self, cur):
        cur.execute(
            """
            SELECT C.nome
            FROM squadra AS S
            JOIN categoria AS C ON C.id = S.categoria
            JOIN rosa AS R ON R.squadra = S.id
            WHERE R.atleta = ? AND
            stagione = (SELECT anno_inizio FROM stagione WHERE corrente IS TRUE);
            """,
            (self.id,)
        )
        res = []
        for nome in cur.fetchall():
            res.append(nome[0])

        return res

    def possibili_squadre(self, cur):
        cur.execute(
            """
            SELECT S.id, C.nome AS squadra
            FROM Utente AS U
            JOIN Atleta AS A ON A.utente = U.id
            JOIN Squadra AS S ON YEAR(U.data_nascita) BETWEEN S.anno_min AND S.anno_max
            JOIN Categoria AS C ON S.categoria = C.id AND (U.sesso = C.sesso OR C.sesso IS NULL)
            WHERE S.stagione = (SELECT anno_inizio FROM Stagione WHERE corrente IS TRUE)
            AND (getUserAge(U.id) >= 18 OR EXISTS (
                SELECT *
                FROM Tutela
                WHERE atleta = U.id
            ))
            AND U.id = ?;
            """,
            (self.id,)
        )
        res = cur.fetchall()
        return res if len(res) > 0 else []

    def aggiungi_squadra(self, cur, squadra):
        try:
            cur.execute(
                "INSERT INTO rosa VALUES (?, ?)",
                (self.id, squadra)
            )
            print(Fore.GREEN + "AGGIUNTO ALLA SQUADRA" + Style.RESET_ALL)
        except mariadb.Error as e:
            print(Fore.RED + "Non puoi iscriverti a questa squadra." + Style.RESET_ALL)


    def menu(self, cur):
        choice = None
        res = None
        print()
        print(Fore.GREEN + "DASHBOARD ATLETA" + Style.RESET_ALL)
        while True:
            print()
            print("[0]\tIndietro")
            print("[1]\tVisualizza il tuo calendario del mese")
            print("[2]\tVisualizza le squadre di cui fai parte in questa stagione")
            print("[3]\tPartecipa ad una nuova squadra")

            choice = int(input(Fore.GREEN + "> " + Style.RESET_ALL))

            if choice == 1:
                res = self.calendario(cur)
                if len(res) > 0:
                    for evento in res:
                        print('\t' + evento['data'] + '\t' + evento['nome'])
                else: print("\tNon hai nulla in programma questo mese.")
            elif choice == 2:
                res = self.squadre(cur)
                if len(res) > 0:
                    for squadra in res:
                        print('\t' + squadra)
                else: print("\tNon sei iscritto a nessuna squadra.")
            elif choice == 3:
                res = self.possibili_squadre(cur)
                if len(res) > 0:
                    print("Inserisci il numero corrispondente ad una delle seguenti squadre o zero per uscire:")
                    for id, squadra in res:
                        print("[" + str(id) + "]" + '\t' + squadra)
                    choice = int(input(Fore.GREEN + "> " + Style.RESET_ALL))
                    self.aggiungi_squadra(cur, choice)
                else: print("\tNon ci sono squadra a cui puoi partecipare.")
            else:
                return

