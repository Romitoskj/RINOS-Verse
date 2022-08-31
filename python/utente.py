from colorama import Fore, Back, Style
import bcrypt
import mariadb
from atleta import Atleta
from allenatore import Allenatore
from tutore import Tutore
from dirigente import Dirigente

class Utente:

    def __init__(self, username, password, nome = None, cognome = None, data_nascita = None, sesso = None, email = None, telefono = None, tessera = None):
        self.id = None
        self.atleta = None # aggiungere a questi campi oggetto atleta se true
        self.allenatore = None
        self.tutore = None
        self.dirigente = None
        self.username = username
        self.password = password # bcrypt.hashpw(str.encode(password), bcrypt.gensalt())
        self.nome = nome
        self.cognome = cognome
        self.data_nascita = data_nascita
        self.sesso = sesso
        self.email = email
        self.telefono = telefono
        self.tessera = tessera

    def __str__(self):
        return self.username

    def login(self, cursor):
        cursor.execute(
            """
            SELECT id, password, AT.utente, AL.utente, T.utente, D.utente
            FROM utente
            LEFT JOIN Atleta AS AT ON AT.utente = id
            LEFT JOIN Allenatore AS AL ON AL.utente = id
            LEFT JOIN Tutore AS T ON T.utente = id
            LEFT JOIN Dirigente AS D ON D.utente = id
            WHERE username = ?;
            """, (self.username,)
        )
        res = cursor.fetchone()
        if not res:
            raise Exception('Username inesistente')
        id, psw, atl, all, tut, dir = res
        if (psw != self.password): raise Exception('Password errata')
        # if not bcrypt.checkpw(str.encode(self.password), psw):
        #    raise Exception("Password errata")
        self.id = id
        if atl: self.atleta = Atleta(atl)
        if all: self.allenatore = Allenatore(all)
        if tut: self.tutore = Tutore(cursor, tut)
        if dir: self.dirigente = Dirigente(dir)
    
    def signup(self, cursor):
        cursor.execute(
            """
            INSERT INTO Utente (username, password, cognome, nome, data_nascita, sesso, email, telefono, tessera)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);
            """,
            (self.username, self.password, self.cognome, self.nome, self.data_nascita, self.sesso, self.email, self.telefono, self.tessera)
        )
        
        self.login(cursor)

    def menu(self, cursor):
        choice = None
        print(Fore.GREEN + "Benvenuto " + str(self).capitalize() + "!" + Style.RESET_ALL)
        while True:
            print()
            print("[0]\tLog out")
            if self.atleta: print("[1]\tEntra come atleta")
            else: print("[1]\tRegistrati come atleta")
            if self.allenatore: print("[2]\tEntra come allenatore")
            else: print("[2]\tRegistrati come allenatore")
            if self.tutore: print("[3]\tEntra come tutore")
            else: print("[3]\tRegistrati come tutore")
            if self.dirigente: print("[4]\tEntra come dirigente")
            else: print("[4]\tRegistrati come dirigente")

            choice = int(input(Fore.GREEN + "> " + Style.RESET_ALL))

            if choice == 1:
                if self.atleta: self.atleta.menu(cursor)
                else:
                    try:
                        self.atleta = Atleta.signin(cursor, self.id)
                        print(Fore.GREEN + "REGISTRAZIONE EFFETTUATA" + Style.RESET_ALL)
                    except mariadb.Error as e:
                        print(Fore.RED + str(e) + Style.RESET_ALL)
            elif choice == 2:
                if self.allenatore: self.allenatore.menu(cursor)
                else:
                    try:
                        self.allenatore = Allenatore.signin(cursor, self.id)
                        print(Fore.GREEN + "REGISTRAZIONE EFFETTUATA" + Style.RESET_ALL)
                    except mariadb.Error as e:
                        print(Fore.RED + str(e) + Style.RESET_ALL)
            elif choice ==3:
                if self.tutore: self.tutore.menu(cursor)
                else:
                    try:
                        self.tutore = Tutore.signin(cursor, self.id)
                        print(Fore.GREEN + "REGISTRAZIONE EFFETTUATA" + Style.RESET_ALL)
                    except mariadb.Error as e:
                        print(Fore.RED + str(e) + Style.RESET_ALL)
            elif choice == 4:
                if self.dirigente: self.dirigente.menu(cursor)
                else:
                    try:
                        self.dirigente = Dirigente.signin(cursor, self.id)
                        print(Fore.GREEN + "REGISTRAZIONE EFFETTUATA" + Style.RESET_ALL)
                    except mariadb.Error as e:
                        print(Fore.RED + str(e) + Style.RESET_ALL)
            else:
                return
