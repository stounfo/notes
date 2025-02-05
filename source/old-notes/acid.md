---
related:
    - "[[Database]]"
---

# ACID

## Atomicity

This ensures that all operations within a transaction are completed
successfully; if not, the transaction is aborted at the fail point and
previously completed operations are rolled back to their state before the
transaction was started. In other words, a transaction is viewed as one single
"unit of work", which either completes in its entirety or not at all.

## Consistency

This ensures that a transaction brings the database from one valid state to
another. At the start of a transaction, the database is in a consistent state,
and once the transaction has completed, it should again be in a consistent
state. This doesn't mean that a transaction can't change data, but rather that
the data should be valid according to predefined rules and constraints after the
transaction is completed.

## Isolation

This ensures that concurrent execution of transactions leaves the database in
the same state that would have been obtained if the transactions were executed
sequentially. That is, the intermediate state of a transaction is invisible to
other transactions. As a result, transactions are shielded from the effects of
other ongoing transactions. To ensure it, there several
[Transaction levels in postgres](transaction_levels_in_postgres.md) in relation databases.

## Durability

Once a transaction has been committed, it will remain committed even in the case
of a system failure. This often involves writing transaction logs to storage
mechanisms that can survive system crashes, so that any transactions that had
been committed but not yet written to the main database can be completed upon
recovery.
