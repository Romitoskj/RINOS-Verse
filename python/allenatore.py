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
        
    def menu(self, cur):
        choice = None
        print()
        print(Fore.GREEN + "DASHBOARD ALLENATORE" + Style.RESET_ALL)
        while True:
            print("[0]\tTorna al menu iniziale")

            choice = int(input(Fore.GREEN + "> " + Style.RESET_ALL))

            return