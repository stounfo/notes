---
related:
    - "[[PostgreSQL]]"
---

# Alternative output mode x

In psql or pgcli clients if a row in a table is too long, you can turn on `\x`
(X for eXpanded listing) mode to control whether table listings use a wide or
narrow format.

**Example:** Here’s an expanded listing:

```
postgres=# \l

                                  List of databases
   Name    |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges
-----------+----------+----------+-------------+-------------+-----------------------
 foo       | tom      | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 foobarino | tom      | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 postgres  | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
```

Use `\x on` for narrower listings:

```txt
postgres=# \l

-[ RECORD 1 ]-----+----------------------
Name              | foo
Owner             | tom
Encoding          | UTF8
Collate           | en_US.UTF-8
Ctype             | en_US.UTF-8
Access privileges |
-[ RECORD 2 ]-----+----------------------
Name              | foobarino
Owner             | tom
Encoding          | UTF8
Collate           | en_US.UTF-8
Ctype             | en_US.UTF-8
Access privileges |
-[ RECORD 3 ]-----+----------------------
Name              | postgres
Owner             | postgres
Encoding          | UTF8
Collate           | en_US.UTF-8
Ctype             | en_US.UTF-8
Access privileges |
```
