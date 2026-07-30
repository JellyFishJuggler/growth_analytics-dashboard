from db_connector import get_connection

conn = get_connection()
cursor = conn.cursor()

tables = [
    "orders",
    "order_details",
    "sales_target"
]

print("=" * 40)
print("DATABASE VERIFICATION")
print("=" * 40)

for table in tables:
    cursor.execute(f"SELECT COUNT(*) FROM {table}")
    count = cursor.fetchone()[0]
    print(f"{table:15} : {count} records")

print("\nSample Orders:")
cursor.execute("SELECT * FROM orders LIMIT 5")
for row in cursor.fetchall():
    print(row)

print("\nSample Order Details:")
cursor.execute("SELECT * FROM order_details LIMIT 5")
for row in cursor.fetchall():
    print(row)

print("\nSample Sales Target:")
cursor.execute("SELECT * FROM sales_target LIMIT 5")
for row in cursor.fetchall():
    print(row)

cursor.close()
conn.close()