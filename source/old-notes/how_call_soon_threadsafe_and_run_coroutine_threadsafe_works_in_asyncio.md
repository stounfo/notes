---
related:
    - "[[Python]]"
---

# How call_soon_threadsafe and run_coroutine_threadsafe works in asyncio?

**run_coroutine_threadsafe** wraps a corountine in a callback and just uses
**call_soon_threadsafe**.

The implementation of **call_soon_threadsafe** for **SelectorEventLoop** is
almost identical to **call_soon**, but it sends a bite into the self-pipe socket
to wake up the event loop, which could remain asleep until it receives data from
a socket.
