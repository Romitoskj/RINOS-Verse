import mariadb
import bcrypt

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

    try:
        # execute a query
        cur.execute("INSERT INTO squadra (categoria, stagione, anno_min, anno_max) VALUES ('ESEM', 2021, 0, 100);")
        #cur.execute("SELECT ROW_COUNT();")
        #print(cur.fetchall())

        # get columns' name
        # cols = [x[0] for x in cur.description]
        #cur.execute("SELECT * FROM squadra")
        # print result of a query
        #for squadra in cur:
        #    print(squadra)

    except mariadb.Error as e:
        print(f"Error: {e}")


    # get number of affected rows
    # cur.execute("INSERT INTO T() VALUES(),(),();")
    # cur.execute("SELECT ROW_COUNT();")
    # print(cur.fetchone()[0])

    # catch exception from dbms
    # try:
    #     cur.execute("some MariaDB query")
    # except mariadb.Error as e:
    #     print(f"Error: {e}")
    
    conn.close()
    
    psd = "la mia password"
    h = bcrypt.hashpw(str.encode(psd), bcrypt.gensalt())
    print(h)
    print(len(h))
    print(bcrypt.checkpw(str.encode("la mia password"), h))
