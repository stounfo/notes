---
related: "[[PostgreSQL]]"
---

# Transaction levels in postgres

Transaction isolation levels define the extent to which the operations in one
transaction are isolated from the operations in other concurrent transactions.
Different levels of isolation have different trade-offs between performance and
the risk of encountering data anomalies.

## Levels

1. **Read Uncommitted**:

    - PostgreSQL's Read Uncommitted behaves like Read Committed. This is due to
      MVCC, which naturally avoids "dirty reads". Any SELECT within a
      transaction sees only committed data as of the start of that statement.

2. **Read Committed**:

    - This is the default isolation level in PostgreSQL.
    - **Impossible Anomalies**: dirty read, lost update.

3. **Repeatable Read**:

    - Ensures that if a transaction reads a certain value, it will see that same
      value on subsequent reads throughout its life. However, unlike in some
      other databases, in PostgreSQL, "Repeatable Read" is immune to phantom
      reads due to its implementation of multi-version concurrency control
      (MVCC).
    - **Impossible Anomalies**: dirty read, lost update, non-repeatable read,
      phantom read

4. **Serializable**:
    - This is the strictest isolation level.
    - Ensures that transactions are executed in such a way that the result is
      equivalent to having run them serially.
    - PostgreSQL uses Serializable Snapshot Isolation (SSI) to manage this
      level. This method detects potential conflicts between serializable
      transactions and rolls one back if necessary.
    - **Impossible Anomalies**: all.

## Anomalies types

1. **Lost Update**:

    - This occurs when two transactions, which are operating concurrently, both
      read a value and then update it. If they do this without proper controls,
      the last update will overwrite any update made by the first transaction,
      effectively "losing" the first transaction's update.
    - For example, two users read a bank balance as $100 concurrently. One adds
      $10, and the other subtracts $20. If both save their changes based only on
      the original read, then the final balance might be $80 or $110, depending
      on who saves last, instead of the correct $90.

2. **Dirty Read**:

    - This happens when a transaction reads data that has been written by
      another ongoing (not yet committed) transaction. If the ongoing
      transaction fails and rolls back, the transaction that read the
      uncommitted data will have read "dirty" data that shouldn't exist.
    - For instance, in a banking application, if one transaction is transferring
      money from one account to another but hasn't completed, a second
      transaction might see the transferred amount in one account but not see
      the corresponding deduction in the other if it reads the data
      mid-operation.

3. **Non-repeatable Read**:

    - Occurs when, within one transaction, a certain value is read multiple
      times, and in between those reads, another transaction modifies that
      value. This means that the value read by the first transaction is not
      "repeatable" because it has changed during the transaction.
    - Example: A user checks the price of an item and sees it's $100. Another
      user changes the price to $110. When the first user checks the price
      again, it has changed, even within the same transaction.

4. **Phantom Read**:

    - This happens when a transaction reads a set of rows that match some
      condition (e.g., all rows where value > 10), and another concurrent
      transaction inserts, deletes, or updates rows such that a subsequent read
      with the same condition by the first transaction returns a different set
      of rows.
    - Example: A user lists all items priced at $100. Another user adds a new
      item at $100. When the first user lists items again, a new item ("phantom"
      row) appears.

5. **Write skew**:

    - Write skew is a type of concurrency anomaly that can occur in database
      systems. Write skew happens when two transactions read overlapping data,
      make decisions based on what they've read, and then both transactions
      modify the data in a way that's inconsistent with both of those decisions.
    - Example:
        1. Two doctors, Alice and Bob, are currently on call.
        2. Alice wants to take a break, so she checks the system to see if other
           doctors are on call. She sees Bob is on call.
        3. At the same time, Bob wants to take a break and checks the system
           too. He sees Alice is on call.
        4. Believing that the other doctor is on call, both Alice and Bob decide
           to go off call.
        5. Both update the system to set their status to "off call".
        6. Now, there's no doctor on call, which violates the hospital's rule.
