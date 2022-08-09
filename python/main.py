import mariadb

def print_hi(name):
    print(f'Hi, {name}')  # Press Ctrl+F8 to toggle the breakpoint.


if __name__ == '__main__':
    connection_args = {
        "user" : "root",
        "password" : "",
        "host" : "localhost",
        "database" : "test"
    }

    cursor = mariadb.connect(**connection_args).cursor()
    cursor.execute("SELECT * FROM t;")
    # print(cursor.fetchall())
    for id, is_true in cursor:
        print(id, is_true)
