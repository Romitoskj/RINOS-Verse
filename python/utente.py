import bcrypt
import mariadb

class Utente:

    def __init__(self, username, password):
        id = None
        self.username = username
        self.password = bcrypt.hashpw(str.encode(password), bcrypt.gensalt())

    def __init__(self, username, password, nome, cognome, data_nascita, sesso, email = None, telefono = None, tessera = None):
        self.username = username
        self.password = bcrypt.hashpw(str.encode(password), bcrypt.gensalt())
        self.nome = nome
        self.cognome = cognome
        self.data_nascita = data_nascita
        self.sesso = sesso


    def login(self, cursor):
        try:
            cursor.execute(
                f"""
                SELECT id, password
                FROM utente 
                WHERE username = {self.username}
                """
            )
            id, psw = cursor.fetchone()
            if not bcrypt.checkpw(str.encode(self.password), psw):
                raise Exception("Password errata")
            self.id = id
        except mariadb.Error as e:
            print(e)
    
    def signin()
