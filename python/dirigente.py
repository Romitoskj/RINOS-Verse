import mariadb
from colorama import Fore, Back, Style

class Dirigente:

    def __init__(self, id):
        self.id = id

    def signin(cur, id):
        cur.execute(
            "INSERT INTO dirigente VALUES (?)",
            (id,)
        )
        return Dirigente(id)

    def squadre(self, cur):
        cur.execute(
            """
            SELECT C.nome, U.nome, U.cognome
            FROM squadra AS S
            JOIN Staff AS ST ON ST.squadra = S.id
            JOIN Utente AS U ON U.id = ST.allenatore
            JOIN Categoria AS C ON C.id = S.categoria
            WHERE stagione = (SELECT anno_inizio FROM Stagione WHERE corrente IS TRUE);
            """
        )
        squadre = {}
        res = cur.fetchall()
        if res:
            for categoria, nome, cognome in res:
                squadre.setdefault(categoria, []).append(nome + " " + cognome)
            return squadre
        else:
            return None

    #TODO aggiungi squadra
    def add_squadra(self, cur):
        cur.execute("SELECT id, nome FROM CATEGORIA;")
        categorie = dict(cur.fetchall())
        while True:
            print("Seleziona la categoria della squadra:")
            print("[0]\tIndietro")
            for id, nome in categorie.items():
                print(f"[{id}]\t{nome}")
            choice = input(Fore.GREEN + "> " + Style.RESET_ALL)
            if choice == '0': return
            if choice not in categorie.keys():
                print(Fore.RED + "Categoria non presente." + Style.RESET_ALL)
                continue
            try:
                cur.execute("""
                INSERT INTO Squadra (categoria, stagione)
                VALUES
                (?,(SELECT anno_inizio FROM STAGIONE WHERE CORRENTE IS TRUE))
                """,
                (choice,)
                )
                cur.execute("SELECT MAX(ID) FROM SQUADRA;")
                squadra = cur.fetchone()[0]
                cur.execute("SELECT ID, NOME, COGNOME FROM UTENTE JOIN ALLENATORE ON utente = id;")
                allenatori = {a[0] : a[1] + " " + a[2] for a in cur.fetchall()}
                while True:
                    print("Seleziona lo staff degli allenatori:")
                    print("[0]\tConferma")
                    for id, nome in allenatori.items():
                        print(f"[{id}]\t{nome}")
                    choice = int(input(Fore.GREEN + "> " + Style.RESET_ALL))
                    if choice == 0: return
                    if choice not in allenatori.keys():
                        print(Fore.RED + "Allenatore inesistente." + Style.RESET_ALL)
                        continue
                    try:
                        cur.execute("""
                        INSERT INTO staff (squadra, allenatore)
                        VALUES
                        (?,?)
                        """,
                        (squadra, choice)
                        )
                    except mariadb.Error as e:
                        print(Fore.RED + "L'allenatore fa già parte dello staff di questa squadra." + Style.RESET_ALL)
            except mariadb.Error as e:
                print(Fore.RED + "Una squadra di questa categoria è già presente nella stagione corrente." + Style.RESET_ALL)
            

        
    def menu(self, cur):
        choice = None
        print()
        print(Fore.GREEN + "DASHBOARD DIRIGENTE" + Style.RESET_ALL)
        while True:
            print()
            print("[0]\tIndietro")
            print("[1]\tGestisci le squadre della stagione in corso")
            print("[2]\tCrea una nuova squadra per la stagione in corso")

            choice = int(input(Fore.GREEN + "> " + Style.RESET_ALL))

            if choice == 1:
                squadre = self.squadre(cur)
                if squadre:
                    for squadra, allenatori in squadre.items():
                        print("\tSquadra: " + squadra + "\n\tStaff:")
                        for a in allenatori:
                            print(f"\t\t"+a)
                        print()
                else:
                    print("Non ci sono squadre attive durante la stagione in corso.")
            elif choice == 2:
                self.add_squadra(cur)
            else:
                return