---
related:
    - "[[PostgreSQL]]"
---

# serial vs identity in posgresql

`serial` is the "old" implementation of auto-generated unique values that has
been part of Postgres for ages. However that is not part of the SQL standard.

To be more compliant with the SQL standard, Postgres 10 introduced the syntax
using `generated as identity`.

```sql
create table t1 (id bigserial primary key); -- bad
create table t2 (id bigint primary key generated always as identity); -- good
```
