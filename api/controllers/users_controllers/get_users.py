from services import select_users

async def get_items(skip: int = 0, limit: int = 100):
    return {"list": await select_users(skip, limit), "skip": skip, "limit": limit}