---
related:
    - "[[Python]]"
---

# Semaphores in asyncio

## Semaphores

Semaphores allow multiple concurrent tasks (threads/processes/async) to access a
shared resource with limited capacity.

### Example with concurrent HTTP requests

```python
import asyncio
from asyncio import Semaphore
from aiohttp import ClientSession

semaphore = Semaphore(10)

async def get_url(url: str, session: ClientSession, semaphore: Semaphore):
    print("Waiting to acquire semaphore...")
    async with semaphore:
        print("Acquired semaphore, requesting...")
        response = await session.get(url)
        print("Finished requesting")
        return response.status

async def main():
    async with ClientSession() as session:
        tasks = [
            get_url(
                "https://www.example.com",
                session,
                semaphore
            ) for _ in range(1000)
        ]
        await asyncio.gather(*tasks)

asyncio.run(main())
```

> [!WARNING] Don't use semaphores without with statement because you can release
> the semaphore more times than it was acquired, and it can increase the max
> acquired counter. Use **BoundedSemaphore** instead

## BoundedSemaphore

This semaphore behaves exactly as previous, with the key difference being that
release will throw a `ValueError: BoundedSemaphore released too many times`
exception if we call release such that it would change the available permits.

### Example

```python
import asyncio
from asyncio import BoundedSemaphore

async def main():
    semaphore = BoundedSemaphore(1)
    await semaphore.acquire()
    semaphore.release()
    semaphore.release()  # raise ValueError here

asyncio.run(main())
```
