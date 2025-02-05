---
related:
    - "[[Patterns]]"
---

# Circuit breaker pattern

The Circuit Breaker pattern is a software design pattern used to enhance the
stability and resilience of a system by preventing it from making requests that
are likely to fail. Imagine it as an electrical circuit breaker in your home,
which automatically shuts off the electric flow when there's a risk of an
overload to prevent damage.

In the context of software, the Circuit Breaker pattern monitors the number of
recent failures that occur when the application tries to perform operations,
such as accessing a remote service. If the failures reach a certain threshold,
the circuit breaker trips, meaning it temporarily blocks any further attempts to
perform the operation. During this "**open**" state, the application can
redirect requests to a fallback mechanism, return an error immediately, or try
some recovery measures, sparing the system from performing futile actions that
are likely to fail.

After a predefined period, the circuit breaker enters a "**half-open**" state,
allowing a limited number of test requests to go through to the remote service.
If these requests succeed, the circuit breaker assumes the service is back to
normal and resets to the "**closed**" state, allowing all requests to pass
through again. This pattern helps in preventing a cascade of failures in a
distributed system, ensuring the system can continue to operate, albeit in a
possibly degraded mode, during partial outages.

Schema:

```
                  ┌──────┐
            ┌─────┤CLOSED│◄─────┐
            │     └──────┘      │
            │                   │
failure threshold exceeded      │
            │                   │
          ┌─▼──┐             success
       ┌──┤OPEN│◄────┐          │
       │  └────┘     │          │
       │           failure      │
     delay           │          │
       │         ┌─────────┐    │
       └────────►│HALF_OPEN│────┘
                 └─────────┘
```
