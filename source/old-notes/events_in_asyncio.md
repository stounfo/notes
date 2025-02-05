---
related:
    - "[[Python]]"
---

# Events in asyncio

Event class keeps track of a flag that indicates whether the event has happened
yet. We can control this flag is with two methods, set and clear.

## Example

```python
import asyncio
import functools
from asyncio import Event

event = asyncio.Event()

def trigger_event(event: Event):
    event.set()

async def do_work_on_event(event: Event):
    print("Waiting for event...")
    await event.wait()
    print("Performing work!")
    await asyncio.sleep(1)
    print("Finished work!")
    event.clear()

async def main():
    asyncio.get_running_loop().call_later(
        2, functools.partial(trigger_event, event)
    )  # <- event will be set after 2 seconds
    await asyncio.gather(do_work_on_event(event), do_work_on_event(event))

asyncio.run(main())
```
