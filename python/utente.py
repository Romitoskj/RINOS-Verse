from pickle import NONE
from colorama import Fore, Back, Style
import bcrypt
import mariadb

class Utente:

    def __init__(self, username, password, nome = None, cognome = None, data_nascita = None, sesso = None, email = None, telefono = None, tessera = None):
        self.id = None
        self.atleta = False # aggiungere a questi campi oggetto atleta se true
        self.allenatore = False
        self.tutore = False
        self.dirigente = False
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
        self.atleta = atl
        self.allenatore = all
        self.tutore = tut
        self.dirigente = dir
    
    def signup(self, cursor):
        cursor.execute(
            """
            INSERT INTO Utente (username, password, cognome, nome, data_nascita, sesso, email, telefono, n_tessera)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);
            """,
            (self.username, self.password, self.cognome, self.nome, self.data_nascita, self.sesso, self.email, self.telefono, self.tessera)
        )
        
        self.login(cursor)

    def menu(self):
        print(Fore.GREEN + "Benvenuto " + str(self) + "!" + Style.RESET_ALL)
        print("[0]\tlog out")
        if self.atleta: print("[1]\tentra come atleta")
        else: print("[1]\tregistrati come atleta")
        if self.allenatore: print("[2]\tentra come allenatore")
        else: print("[2]\tregistrati come allenatore")
        if self.tutore: print("[3]\tentra come tutore")
        else: print("[3]\tregistrati come tutore")
        if self.dirigente: print("[4]\tentra come dirigente")
        else: print("[4]\tregistrati come dirigente")

        choice = int(input(Fore.GREEN + "> " + Style.RESET_ALL))
