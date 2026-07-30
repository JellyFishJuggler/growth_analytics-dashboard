import mysql.connector


def get_connection():
    connection = mysql.connector.connect(
        host="localhost",
        user="srijan",
        password="DataSci@2026!",
        database="growth_analytics"
    )

    return connection

if __name__ == "__main__":
    conn = get_connection()

    if conn.is_connected():
        print("Database Connected Successfully!")

    conn.close()