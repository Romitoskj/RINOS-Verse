import mariadb


if __name__ == '__main__':
    connection_args = {
        "user" : "root",
        "password" : "",
        "host" : "localhost",
        "database" : "rinos"
    }

    conn = mariadb.connect(**connection_args)
    cur = conn.cursor()

    # execute a query
    # cur.execute("SELECT * FROM t;")
    
    # get result of a query
    # for id, is_true in cur:
    #     print(id, is_true)


    # catch exeption from dbms
    # try:
    #     cur.execute("some MariaDB query")
    # except mariadb.Error as e:
    #     print(f"Error: {e}")

    conn.close()
