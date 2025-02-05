---
related:
    - "[[Programming]]"
---

# Concurrency vs Parallelism

## Concurrency

- **Definition**: Concurrency focuses on managing multiple tasks to appear as
  if they are happening simultaneously, even if they might not be executed at
  the exact same time.
- **Real-world Analogy**: Imagine a chef who is preparing a three-course meal.
  The chef might start boiling water, then while it's boiling, chop
  vegetables. The chef manages multiple tasks but not necessarily all at once.
- **Usage in Computer Science**: It's useful in systems that need to handle
  multiple tasks or users but might process them one after the other, like a
  single-threaded web server handling multiple web requests by quickly
  switching between them.

## Parallelism

- **Definition**: Parallelism involves executing multiple tasks or processes
  at the exact same time.
- **Real-world Analogy**: In a kitchen, imagine multiple chefs each preparing
  a different dish. They're all working simultaneously.
- **Usage in Computer Science**: Achieved in systems with multiple processing
  units. In a multi-core CPU, different cores can process different tasks
  simultaneously, ideal for tasks like processing large datasets more quickly.
