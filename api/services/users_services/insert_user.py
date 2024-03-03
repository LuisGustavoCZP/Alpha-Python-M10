from configs import postgres

async def insert_user (name: str):
    query = """
        INSERT INTO items 
        (name, created_at) VALUES (%s, now()) 
        RETURNING *;
    """
    postgres.execute(query, [name])
    postgres.commit()
    response = postgres.fetch()
    return response