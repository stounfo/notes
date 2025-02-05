---
related: [[Programming]]
---

# Preemptive and cooperative multitasking

Multitasking refers to the ability of an operating system or a computing device
to handle multiple tasks or processes concurrently.

## Preemptive multitasking

In this model, we let the operating system decide how to switch between which
work is currently being executed via a process called **time slicing**. When the
operating system switches between work, we call it **preempting**. How this
mechanism works under the hood is up to the operating system itself. It is
primarily achieved through using either multiple threads or multiple processes.
Example: threads/processes in OS

## Cooperative multitasking

In this model, instead of relying on the operating system to decide when to
switch between which work is currently being executed, we explicitly code points
in our application where we can let other tasks run. The tasks in our
application operate in a model where they cooperate, explicitly saying, “I’m
pausing my task for a while; go ahead and run other tasks.” Example: asyncio in
python
