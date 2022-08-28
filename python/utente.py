from pickle import NONE
import bcrypt
import mariadb

class Utente:

    def __init__(self, username, password, nome = None, cognome = None, data_nascita = None, sesso = None, email = None, telefono = None, tessera = None):
        self.id = None
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
        return f"id: {self.id}, username: {self.username}"    

    def login(self, cursor):
        cursor.execute(
            """
            SELECT id, password
            FROM utente 
            WHERE username = ?;
            """, (self.username,)
        )
        res = cursor.fetchone()
        if not res:
            raise Exception('Username inesistente')
        id, psw = res
        if (psw != self.password): raise Exception('Password errata')
        # if not bcrypt.checkpw(str.encode(self.password), psw):
        #    raise Exception("Password errata")
        self.id = id
    
    def signup(self, cursor):
        cursor.execute(
            """
            INSERT INTO Utente (username, password, cognome, nome, data_nascita, sesso, email, telefono, n_tessera)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);
            """,
            (self.username, self.password, self.cognome, self.nome, self.data_nascita, self.sesso, self.email, self.telefono, self.tessera)
        )
        
        self.login(cursor)
