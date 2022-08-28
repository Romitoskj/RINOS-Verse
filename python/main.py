import mariadb
from getpass import getpass
from utente import Utente

# TODO classe utente e sotto classe per ogni tipologia
if __name__ == '__main__':
    connection_args = {
        "user": "root",
        "password": "",
        "host": "localhost",
        "database": "rinos",
        "autocommit": True # default false e conn.commit e rollback
    }

    try:
        conn = mariadb.connect(**connection_args)
    except mariadb.Error as e:
        print(f"Error: {e}")
    
    cur = conn.cursor()

    while(True):
        try:
            username = input("Username: ")
            password = getpass()
            user = Utente(username, password)
            user.login(cur)
            break
        except Exception as e:
            print(e)
