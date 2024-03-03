"""
Provides Postgres connection
"""

import psycopg2

class Postgres:
    """
    Postgres Abstraction
    """
    def __init__(self, configs) -> None:
        self.con = psycopg2.connect(**configs)
        self.cursor = self.con.cursor()

    def execute (self, query:str, values:list|None = None):
        """
        Execute a basic query
        """
        if values is None:
            self.cursor.execute(query)
        else:
            self.cursor.execute(query, values)

    def fetch (self):
        """
        Fetch one query
        """
        return self.cursor.fetchone()

    def fetchall (self):
        """
        Fetch all queries
        """
        return self.cursor.fetchall()

    def commit (self):
        """
        Commit query
        """
        self.con.commit()

    def rollback (self):
        """
        Commit query
        """
        self.con.rollback()

    def close (self):
        """
        Close connection
        """
        self.cursor.close()
        self.con.close()
