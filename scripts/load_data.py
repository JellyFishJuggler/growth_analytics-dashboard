import pandas as pd
from pathlib import Path
from db_connector import get_connection

# ==========================================
# File Paths
# ==========================================

BASE_DIR = Path(__file__).resolve().parent.parent
DATA_DIR = BASE_DIR / "data" / "processed"

orders = pd.read_csv(DATA_DIR / "orders_clean.csv")
details = pd.read_csv(DATA_DIR / "order_details_clean.csv")
targets = pd.read_csv(DATA_DIR / "sales_target_clean.csv")

# ==========================================
# Clean Sales Target
# ==========================================

targets = targets.dropna(how="all")

targets = targets[
    ~targets["month_of_order_date"]
    .astype(str)
    .str.startswith("Note:", na=False)
]

targets = targets.dropna(
    subset=[
        "month_of_order_date",
        "category",
        "target"
    ]
)

targets["month_of_order_date"] = pd.to_datetime(
    targets["month_of_order_date"],
    errors="coerce"
)

targets = targets.dropna(subset=["month_of_order_date"])

# ==========================================
# Database Connection
# ==========================================

conn = get_connection()
cursor = conn.cursor()

# ==========================================
# Clear Existing Data
# ==========================================

cursor.execute("SET FOREIGN_KEY_CHECKS = 0")

cursor.execute("TRUNCATE TABLE order_details")
cursor.execute("TRUNCATE TABLE sales_target")
cursor.execute("TRUNCATE TABLE orders")

cursor.execute("SET FOREIGN_KEY_CHECKS = 1")

conn.commit()

# ==========================================
# Insert Orders
# ==========================================

orders_query = """
INSERT INTO orders (
    order_id,
    order_date,
    customername,
    state,
    city
)
VALUES (%s, %s, %s, %s, %s)
"""

orders_data = list(orders.itertuples(index=False, name=None))

cursor.executemany(orders_query, orders_data)
conn.commit()

print(f"Inserted {cursor.rowcount} rows into orders.")

# ==========================================
# Insert Order Details
# ==========================================

details_query = """
INSERT INTO order_details (
    order_id,
    amount,
    profit,
    quantity,
    category,
    sub_category
)
VALUES (%s, %s, %s, %s, %s, %s)
"""

details_data = list(details.itertuples(index=False, name=None))

cursor.executemany(details_query, details_data)
conn.commit()

print(f"Inserted {cursor.rowcount} rows into order_details.")

# ==========================================
# Insert Sales Target
# ==========================================

targets_query = """
INSERT INTO sales_target (
    month_of_order_date,
    category,
    target
)
VALUES (%s, %s, %s)
"""

targets_data = list(targets.itertuples(index=False, name=None))

cursor.executemany(targets_query, targets_data)
conn.commit()

print(f"Inserted {cursor.rowcount} rows into sales_target.")

# ==========================================
# Close Connection
# ==========================================

cursor.close()
conn.close()

print("\n====================================")
print("Data Imported Successfully!")
print("====================================")