import sqlite3
import sys
from pathlib import Path

def main():
    if len(sys.argv) != 2:
        print("Usage: python3 run_sql.py <lab-directory>")
        return
    directory = Path(__file__).parent / sys.argv[1]
    params = {"client": "Fresh Market", "surname": "Иванов", "employee_id": 1, "supplier_id": 1}
    with sqlite3.connect(":memory:") as db:
        db.executescript((directory / "schema.sql").read_text())
        source = (directory / "queries.sql").read_text()
        statement = ""
        for line in source.splitlines():
            if line.strip().startswith("--"):
                continue
            statement += line + "\n"
            if not sqlite3.complete_statement(statement):
                continue
            query = statement.strip()
            if query.upper() == "BEGIN;":
                db.commit()
            cursor = db.execute(query, params)
            if cursor.description:
                print(" | ".join(column[0] for column in cursor.description))
                for row in cursor:
                    print(" | ".join(str(value) for value in row))
                print()
            statement = ""
        if statement.strip():
            raise ValueError("Incomplete SQL statement")

if __name__ == "__main__":
    main()
