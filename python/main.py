import mariadb


if __name__ == '__main__':
    connection_args = {
        "user": "root",
        "password": "",
        "host": "localhost",
        "database": "test"
    }

    conn = mariadb.connect(**connection_args)
    cur = conn.cursor()

    # execute a query
    # cur.execute("SELECT * FROM t;")

    # get columns' name
    # cols = [x[0] for x in cur.description]
    
    # print result of a query
    # for id, is_true in cur:
    #     print(id, is_true)

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
