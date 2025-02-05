---
related:
    - "[[Python]]"
---

# Sync python to async python with asyncio

## Use ProcessPoolExecutor

```python
from concurrent.futures import ProcessPoolExecutor
from multiprocessing import Value
import asyncio
from functools import partial

shared_counter = None

def increment_and_print(to_print):
    with shared_counter.get_lock():
        shared_counter.value += 1
    print(to_print)

def init(counter):
    global shared_counter
    shared_counter = counter

async def main():
    counter = Value("i", 0)
    with ProcessPoolExecutor(initializer=init, initargs=(counter,)) as pool:
        futures = [
            asyncio.get_running_loop().run_in_executor(
                pool, partial(increment_and_print, word)
            )
            for word in ("hello", "how", "are", "you")
        ] # <- futures start right after being created.
        await asyncio.gather(*futures)
        print("shared_counter:", counter.value)

if __name__ == "__main__":
    asyncio.run(main())
```

## Use ThreadPoolExecutor

### Basic usage

```python
from concurrent.futures import ThreadPoolExecutor
import asyncio
from functools import partial
import threading

counter = 0
lock = threading.Lock()

def increment_and_print(to_print):
    global counter
    with lock:
        counter += 1
    print(to_print)

async def main():
    with ThreadPoolExecutor() as pool:
        futures = [
            asyncio.get_running_loop().run_in_executor(
                pool, partial(increment_and_print, word)
            )
            for word in ("hello", "how", "are", "you")
        ] # <- futures start right after being created.
        await asyncio.gather(*futures)
        print("counter:", counter)

asyncio.run(main())
```

### Use default_executor

```python
import asyncio
from functools import partial
import threading

counter = 0
lock = threading.Lock()

def increment_and_print(to_print):
    global counter
    with lock:
        counter += 1
    print(to_print)

async def main():
    futures = [
        asyncio.get_running_loop().run_in_executor(
            None, partial(increment_and_print, word) # <- None here
        )
        for word in ("hello", "how", "are", "you")
    ] # <- futures start right after being created.
    await asyncio.gather(*futures)
    print("counter:", counter)

asyncio.run(main())
```

### Set default_executor

```python
from concurrent.futures import ThreadPoolExecutor
import asyncio
from functools import partial
import threading

counter = 0
lock = threading.Lock()

def increment_and_print(to_print):
    global counter
    with lock:
        counter += 1
    print(to_print)

async def main():
    with ThreadPoolExecutor(max_workers=2) as pool:
        loop = asyncio.get_running_loop()
        loop.set_default_executor(pool) # <- can set thread-based only

        futures = [
            loop.run_in_executor(
                None, partial(increment_and_print, word)  # <- None here
            )
            for word in ("hello", "how", "are", "you")
        ] # <- futures start right after being created.
        await asyncio.gather(*futures)
        print("counter:", counter)

asyncio.run(main())
```

### Use to_thread

```python
import asyncio
import threading

counter = 0
lock = threading.Lock()

def increment_and_print(to_print):
    global counter
    with lock:
        counter += 1
    print(to_print)

async def main():
    cors = [
        # functions will be executed in the default executor
        asyncio.to_thread(increment_and_print, word)
        for word in ("hello", "how", "are", "you")
    ]
    await asyncio.gather(*cors) # <- all cors starts here
    print("counter:", counter)

asyncio.run(main())
```
