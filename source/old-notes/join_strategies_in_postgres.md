---
related: "[[PostgreSQL]]"
---

# Join strategies in postgres

## Nested Loop Join

A simple method where for each row in the first table, the database scans every
row in the second table looking for matches. It's essentially a loop within a
loop, which is where it gets its name. This method can be efficient for small
tables or when one of the tables is significantly smaller than the other.

## Merge Join

Both tables are sorted on the join condition and then scanned once, side by
side. Rows with matching join keys are combined as a result. The tables can be
presorted, or the database might sort them as part of the join process. This
method is efficient when both tables have large amounts of data and the join
columns are indexed or can be sorted efficiently.

## Hash Join

In this method, the database creates a temporary hash table of one of the
tables, usually the smaller one, using the join condition as the hash key. It
then scans the second table, hashes each row's join condition, and looks for a
match in the hash table. This method is often efficient when one of the tables
is much smaller than the other, making it feasible to create a hash table for
it.
