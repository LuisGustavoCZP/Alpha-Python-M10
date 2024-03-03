from services import insert_user

async def post_user(item: dict):
    return await insert_user(**item)