---
related: "[[SQL]]"
---

# UNION, INTERSECT, EXCEPT in sql

## UNION

Combines the results of two or more `SELECT` statements into a single result
set, returning all distinct rows from both result sets.

### Example

```sql
SELECT 1 AS A, 2 AS B, 3 AS C
UNION
SELECT 4 AS A, 5 AS B, 6 AS C;
```

```
A | B | C
---------
1 | 2 | 3
4 | 5 | 6
```

## INTERSECT

Returns rows that are common to the result sets of two or more `SELECT`
statements.

### Example

```sql
SELECT 1 AS A, 2 AS B, 3 AS C
INTERSECT
SELECT 1 AS A, 2 AS B, 3 AS C;
```

```
A | B | C
---------
1 | 2 | 3
```

## EXCEPT

Returns rows from the first `SELECT` statement that are not present in the
second `SELECT` statement's results.

### Example

```sql
SELECT 1 AS A, 2 AS B, 3 AS C
EXCEPT
SELECT 2 AS A, 3 AS B, 4 AS C;
```

```
A | B | C
---------
1 | 2 | 3
```
