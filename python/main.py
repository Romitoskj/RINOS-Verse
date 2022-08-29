import mariadb
from colorama import Fore, Back, Style
from getpass import getpass
from utente import Utente

# ritorna la stringa inserita dall'utente se non è vuota, altrimenti None
def user_input(message):
    val = input(message)
    return val if val else None

def menu_iniz(cur):
    user = None
    print()
    print(Fore.GREEN + "RINOS VERSE")
    print(Style.RESET_ALL)
    print("[0]\tLog in")
    print("[1]\tSign up")

    choice = int(input(Fore.GREEN + "> " + Style.RESET_ALL))

    if (choice == 0):
        while(True):
            username = user_input("Username: ")
            password = getpass()
            user = Utente(username, password)
            try:
                user.login(cur)
                break
            except Exception as e:
                print(Fore.RED + str(e) + Style.RESET_ALL)
                print("riprovare? (S/N)")
                choice = input(Fore.GREEN + "> " + Style.RESET_ALL)
                if choice.upper() == 'N': break
    else:
        while(True):
            username = user_input("Username: ")
            password = getpass()
            nome = user_input("Nome: ")
            cognome = user_input("Cognome: ")
            data_nascita = user_input("Data di nascita (YYYY-MM-DD): ")
            sesso = user_input("Sesso ('M' o 'F'): ")
            email = user_input("Email: ")
            telefono = user_input("Telefono: ")
            tessera = user_input("Numero tessera: ")

            user = Utente(username, password, nome, cognome, data_nascita, sesso, email, telefono, tessera)
            try:
                user.signup(cur)
                break
            except Exception as e:
                print(Fore.RED + str(e) + Style.RESET_ALL)
                print("riprovare? (S/N)")
                choice = input(Fore.GREEN + "> " + Style.RESET_ALL)
                if choice.upper() == 'N': break
    return user if user.id else None

def main(cur):
    user = menu_iniz(cur)
    if not user: 
        print('Arrivederci!')
        return
    user.menu()

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
    
    main(cur = conn.cursor())

    conn.close()