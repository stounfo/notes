---
related: "[[PostgreSQL]]"
---

# Access methods in postgres

## Seq Scan (Sequential Scan)

Scans every row in the table without using any index. Better with high
selectivity.

## Index Scan

Uses an index to determine which rows to fetch from the table. Better with low
selectivity.

## Index Only Scan

Retrieves data directly from the index without accessing the main table,
provided all needed columns are present in the index. Better with low
selectivity.

## Bitmap Scan

Creates an in-memory bitmap of table row locations based on an index, then
fetches those rows in an optimized manner.
