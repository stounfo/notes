---
related:
    - "[[Python]]"
---

# Methods of concurrent execution in asyncio

## Comparison of methods for concurrent execution

| **Scenario**                                                                 | **create_task** | **TaskGroup** |        **gather**        | **as_completed** |                **wait**                |
| ---------------------------------------------------------------------------- | :-------------: | :-----------: | :----------------------: | :--------------: | :------------------------------------: |
| Perform all tasks, **cancel** the rest if an exception occurs                |        -        |       ✓       |            ✓             |        -         | ✓ FIRST_EXCEPTION with manually-cancel |
| Perform all tasks, **don't cancel** the rest if an exception occurs          |        ✓        |       -       | ✓ return exceptions True |        ✓         |                   ✓                    |
| Perform one task, cancel the rest                                            |        -        |       -       |            -             |        -         | ✓ FIRST_COMPLETED with manually-cancel |
| Process the results of tasks one-by-one as they become ready                 |        -        |       -       |            -             |        ✓         |           ✓ FIRST_COMPLETED            |
| Process the results of tasks in pre-determined order when all tasks are done |        ✓        |       ✓       |            ✓             |        -         |                   -                    |
| Set a timeout for task execution                                             |        -        |       ✓       |            -             |        ✓         |                   ✓                    |
| Perform tasks in background                                                  |        ✓        |       -       |            -             |        -         |                   -                    |

## asyncio.create_task

### Basic Usage

```python
import asyncio

async def say_hello_with_delay(delay):
    await asyncio.sleep(delay)
    print(f"Hello with {delay} sec delay")
    return delay

async def main():
    task1 = asyncio.create_task(say_hello_with_delay(0.2))
    task2 = asyncio.create_task(say_hello_with_delay(0.1))
    res1 = await task1  # <- both tasks start here
    res2 = task2.result()
    print(res1, res2)  # 0.2 0.1

asyncio.run(main())
```

### Handle exception

```python
import asyncio

async def say_hello_with_delay(delay):
    await asyncio.sleep(delay)
    print(f"Hello with {delay} sec delay")
    return delay

async def raise_exception_with_delay(delay):
    await asyncio.sleep(delay)
    print(f"Raise with {delay} sec delay")
    raise ValueError("Error")

async def main():
    task1 = asyncio.create_task(say_hello_with_delay(0.1))
    task2 = asyncio.create_task(raise_exception_with_delay(0.2))
    task3 = asyncio.create_task(say_hello_with_delay(0.3))
    try:
        a, b, c = await task1, await task2, await task3
    except ValueError as e:
        print(e)
    await asyncio.sleep(1)  # Ensure all tasks have time to complete

asyncio.run(main())
```

### Perform in background

```python
import asyncio

background_tasks = set()

async def say_hello_with_delay(delay):
    await asyncio.sleep(delay)
    print(f"Hello with {delay} sec delay")
    return delay

async def main():
    for delay in (0.3, 0.2, 0.1):
        task = asyncio.create_task(say_hello_with_delay(delay))
        # Add task to the set. This creates a strong reference.
        background_tasks.add(task)
        # To prevent keeping references to finished tasks forever,
        # make each task remove its own reference from the set after
        # completion:
        task.add_done_callback(background_tasks.discard)
    await asyncio.sleep(0.4)

asyncio.run(main())
```

## asyncio.TaskGroup

### Basic Usage

```python
import asyncio

async def say_hello_with_delay(delay):
    await asyncio.sleep(delay)
    print(f"hello with {delay} sec delay")
    return delay

async def main():
    async with asyncio.TaskGroup() as tg:  # <- all tasks start in __aexit__
        tasks = [
            tg.create_task(say_hello_with_delay(0.3)),
            tg.create_task(say_hello_with_delay(0.2)),
            tg.create_task(say_hello_with_delay(0.1)),
        ]
    print(f"both tasks have completed now: {[t.result() for t in tasks]}")

asyncio.run(main())
```

### Handle exception

```python
import asyncio

async def say_hello_with_delay(delay):
    await asyncio.sleep(delay)
    print(f"Hello with {delay} sec delay")
    return delay

async def raise_exception_with_delay(delay):
    await asyncio.sleep(delay)
    print(f"Raise with {delay} sec delay")
    raise ValueError("Error")

async def main():
    try:
        async with asyncio.TaskGroup() as tg:
            tg.create_task(say_hello_with_delay(0.1))
            tg.create_task(raise_exception_with_delay(0.2))
            tg.create_task(say_hello_with_delay(0.3))
    except* ValueError as gr:  # <- all exceptions are in ExceptionGroup
        print(*(e for e in gr.exceptions))

asyncio.run(main())
```

### Features

- While waiting, new tasks may still be added to the group (for example, by
  passing `tg` into one of the coroutines and calling `tg.create_task()` in
  that coroutine)
- The first time any of the tasks belonging to the group fails with an
  exception other
  than [`asyncio.CancelledError`](https://docs.python.org/3/library/asyncio-exceptions.html#asyncio.CancelledError),
  the remaining tasks in the group are cancelled.

## asyncio.gather

### Basic usage

```python
import asyncio

async def say_hello_with_delay(delay):
    await asyncio.sleep(delay)
    print(f"Hello with {delay} sec delay")
    return delay

async def main():
    results = await asyncio.gather(
        say_hello_with_delay(0.1),
        say_hello_with_delay(0.2),
        say_hello_with_delay(0.3),
    )
    print(*results)  # 0.1 0.2 0.3

asyncio.run(main())
```

### Handle exception

```python
import asyncio

async def say_hello_with_delay(delay):
    await asyncio.sleep(delay)
    print(f"Hello with {delay} sec delay")
    return delay

async def raise_exception_with_delay(delay):
    await asyncio.sleep(delay)
    print(f"Raise with {delay} sec delay")
    raise ValueError("Error")

async def main():
    try:
        results = await asyncio.gather(
            say_hello_with_delay(0.1),
            raise_exception_with_delay(0.2),
            say_hello_with_delay(0.3),
        )
    except ValueError as e:
        print(e)

asyncio.run(main())
```

### Handle exception with return_exception

```python
import asyncio

async def say_hello_with_delay(delay):
    await asyncio.sleep(delay)
    print(f"Hello with {delay} sec delay")
    return delay

async def raise_exception_with_delay(delay):
    await asyncio.sleep(delay)
    print(f"Raise with {delay} sec delay")
    raise ValueError("Error")

async def main():
    results = await asyncio.gather(
        say_hello_with_delay(0.3),
        raise_exception_with_delay(0.2),
        say_hello_with_delay(0.1),
        return_exceptions=True,
    )
    print(*results)  # 0.3 Error 0.1

asyncio.run(main())
```

## asyncio.as_completed

### Basic usage

```python
import asyncio

async def say_hello_with_delay(delay):
    await asyncio.sleep(delay)
    print(f"Hello with {delay} sec delay")
    return delay

async def main():
    cors = (
        say_hello_with_delay(0.3),
        say_hello_with_delay(0.2),
        say_hello_with_delay(0.1),
    )
    for future in asyncio.as_completed(cors):
        earliest_result = await future
        print(
            "earliest_result:", earliest_result
        )  # <- You can handle the result as it comes

asyncio.run(main())
```

### Handle exception

```python
import asyncio

async def say_hello_with_delay(delay):
    await asyncio.sleep(delay)
    print(f"Hello with {delay} sec delay")
    return delay

async def raise_exception_with_delay(delay):
    await asyncio.sleep(delay)
    print(f"Raise with {delay} sec delay")
    raise ValueError("Error")

async def main():
    cors = [
        say_hello_with_delay(0.3),
        raise_exception_with_delay(0.2),
        say_hello_with_delay(0.1),
    ]
    for future in asyncio.as_completed(cors):
        try:
            await future
        except ValueError as e:
            print(e)

asyncio.run(main())
```

### Cancel remaining tasks if raise (not recommended)

```python
import asyncio

async def say_hello_with_delay(delay):
    await asyncio.sleep(delay)
    print(f"Hello with {delay} sec delay")
    return delay

async def raise_exception_with_delay(delay):
    await asyncio.sleep(delay)
    raise ValueError("Error")

async def main():
    tasks = [
        asyncio.create_task(say_hello_with_delay(0.1)),
        asyncio.create_task(raise_exception_with_delay(0.2)),
        asyncio.create_task(say_hello_with_delay(0.3)),
    ]
    for task in asyncio.as_completed(tasks):
        try:
            print(await task)  # 0 1
        except ValueError:
            [task.cancel() for task in tasks]
            break

asyncio.run(main())
```

### With timeout

```python
import asyncio

async def say_hello_with_delay(delay):
    await asyncio.sleep(delay)
    print(f"Hello with {delay} sec delay")
    return delay

async def main():
    cors = (
        say_hello_with_delay(0.3),
        say_hello_with_delay(0.2),
        say_hello_with_delay(0.1),
    )
    for future in asyncio.as_completed(cors, timeout=0.15):
        try:
            print(await future)
        except TimeoutError as e:
            print("Timeout")

asyncio.run(main())
```

## asyncio.wait

### Basic usage

```python
import asyncio

async def say_hello_with_delay(delay=1):
    await asyncio.sleep(delay)
    print(f"Hello with {delay} sec delay")
    return delay

async def main():
    done, pending = await asyncio.wait(
        (asyncio.create_task(say_hello_with_delay(i)) for i in range(3))
    )
    print(done)
    print(pending)  # <- Always empty in this snippet

asyncio.run(main())
```

### Handle exception

```python
import asyncio

async def say_hello_with_delay(delay):
    await asyncio.sleep(delay)
    print(f"Hello with {delay} sec delay")
    return delay

async def raise_exception_with_delay(delay):
    await asyncio.sleep(delay)
    print(f"Raise with {delay} sec delay")
    raise ValueError("Error")

async def main():
    done, pending = await asyncio.wait(
        (
            asyncio.create_task(say_hello_with_delay(0.1)),
            asyncio.create_task(raise_exception_with_delay(0.2)),
            asyncio.create_task(say_hello_with_delay(0.3)),
        )
    )
    for task in done:
        try:
            await task
        except ValueError as e:
            print(e)
    # or
    for task in done:
        print(task.exception()) if task.exception() else None

asyncio.run(main())
```

### With timeout

```python
import asyncio

async def say_hello_with_delay(delay):
    await asyncio.sleep(delay)
    print(f"Hello with {delay} sec delay")
    return delay

async def main():
    done, pending = await asyncio.wait(
        (asyncio.create_task(say_hello_with_delay(i)) for i in range(3)),
        timeout=1.5
    )
    print(done)  # delay 0 and delay 1
    print(pending)  # delay 2
    # wait does not cancel the futures when a timeout occurs.
    # so we need to cancel them manually
    [task.cancel() for task in pending]

asyncio.run(main())
```

### return_when option

```python
import asyncio

async def say_hello_with_delay(delay):
    await asyncio.sleep(delay)
    print(f"Hello with {delay} sec delay")
    return delay

async def raise_exception_with_delay(delay):
    await asyncio.sleep(delay)
    print(f"Raise with {delay} sec delay")
    raise ValueError("Error")

async def run_with_return_when(return_when):
    done, pending = await asyncio.wait(
        (
            asyncio.create_task(say_hello_with_delay(0.3)),
            asyncio.create_task(raise_exception_with_delay(0.2)),
            asyncio.create_task(say_hello_with_delay(0.1)),
        ),
        return_when=return_when,
    )
    [task.cancel() for task in pending]
    return [
        task.result() if task.exception() is None else task.exception() for task in done
    ]

async def main():
    print("\n====ALL_COMPLETED====")
    print(await run_with_return_when(asyncio.ALL_COMPLETED))  # default
    # [1, 0, ValueError('Error')]
    await asyncio.sleep(0.4)
    print("\n====FIRST_COMPLETED====")
    print(await run_with_return_when(asyncio.FIRST_COMPLETED))
    # [0]
    await asyncio.sleep(0.4)
    print("\n====FIRST_EXCEPTION====")
    print(await run_with_return_when(asyncio.FIRST_EXCEPTION))
    # [0, ValueError('Error'), 1]

asyncio.run(main())
```
