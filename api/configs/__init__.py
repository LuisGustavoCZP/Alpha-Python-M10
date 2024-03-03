"""
Provides DOTENV CONFIG
"""

from os import getenv
import dotenv
from clients.postgres import Postgres

dotenv.load_dotenv()

db_configs = {
    "host": getenv('DB_HOST'),
    "port": getenv('DB_PORT'),
    "database": getenv('DB_DATABASE'),
    "user": getenv('DB_USER'),
    "password": getenv('DB_PASSWORD')
}

postgres = Postgres(db_configs)