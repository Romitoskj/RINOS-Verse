import mariadb
from colorama import Fore, Back, Style

from atleta import Atleta

class Tutore:

    def __init__(self, cur, id):
        self.id = id
        cur.execute(
            """
            SELECT atleta, nome, cognome
            FROM Tutela
            JOIN Utente ON atleta = id
            WHERE tutore = ?;
            """,
            (self.id,)
        )
        res = cur.fetchall()
        if res:
            self.atleti = {atl[0]: {'atleta': Atleta(atl[0]), 'nome': atl[1], 'cognome': atl[2]} for atl in res}
        else:
            self.atleti = {}

    def signin(cur, id):
        cur.execute(
            "INSERT INTO tutore VALUES (?)",
            (id,)
        )
        return Tutore(cur, id)
        
    def allenamenti(self, cur):
        cur.execute(
            """
            SELECT U.id AS id_atleta, U.nome AS atleta, U.cognome, APS.id AS id_allenamento,
                APS.data_ora_inizio AS data_e_ora
            FROM allenamenti_programmati_squadre AS APS 
            JOIN Rosa AS R ON R.squadra = APS.squadra
            JOIN Utente AS U ON U.id = R.atleta
            JOIN Tutela AS T ON T.atleta = R.atleta
            WHERE T.tutore = ?
            ORDER BY APS.data_ora_inizio;
            """,
            (self.id,)
        )
        res = cur.fetchall()
        allenamenti = {}
        if res:
            for _, nome, cognome, _, data in res:
                allenamenti.setdefault(data.strftime("%d/%m/%Y, %H:%M:%S"), []).append(nome + " " + cognome)
            return allenamenti
        else:
            return None

    def menu_atleti(self, cur):
        choice = None
        while True:
            print()
            print("Seleziona un atleta:")
            print("[0]\tIndietro")
            for atl, val in self.atleti.items():
                print(f"[{atl}]\t{val['nome']} {val['cognome']}")

            choice = int(input(Fore.GREEN + "> " + Style.RESET_ALL))
            if choice == 0: return
            if choice not in self.atleti.keys():
                print(Fore.RED + "Atleta non presente." + Style.RESET_ALL)
                continue
            self.atleti[choice]['atleta'].menu(cur)

    def menu(self, cur):
        choice = None
        print()
        print(Fore.GREEN + "DASHBOARD TUTORE" + Style.RESET_ALL)
        while True:
            print()
            print("[0]\tIndietro")
            print("[1]\tVisualizza la dashboard atleti tutelati")
            print("[2]\tVisualizza i prossimi allenamenti degli atleti tutelati")

            choice = int(input(Fore.GREEN + "> " + Style.RESET_ALL))

            if choice == 1:
                if self.atleti:
                    self.menu_atleti(cur)
                else:
                    print("Non tuteli nessun alteta.")
            elif choice == 2:
                all = self.allenamenti(cur)
                if all:
                    for data, atleti in all.items():
                        print("\tAllenamento del " + data + " partecipano:")
                        for a in atleti:
                            print(f"\t\t"+a)
                        print()
                else:
                    print("Gli atleti che tuteli non hanno nessun allenamento in programma.")
            else:
                return