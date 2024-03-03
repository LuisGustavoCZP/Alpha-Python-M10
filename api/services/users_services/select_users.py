from configs import postgres

async def select_users (skip: int = 0, limit: int | str = "ALL", fields=None):

    if fields is not None and len(fields) > 0:
        fields = f"{fields}"
    else: fields = "*"
    
    query = f"""
        SELECT {fields} 
        FROM users
        LIMIT %s
        OFFSET %s
        ;
    """
    postgres.execute(query, [limit, skip])
    response = postgres.fetchall()
    return response