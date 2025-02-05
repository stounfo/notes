---
related:
    - "[[PostgreSQL]]"
---

# text vs varchar vs char in postgresql

| Name                                 | Description                |
| ------------------------------------ | -------------------------- |
| `character varying(n)`, `varchar(n)` | variable-length with limit |
| `character(n)`, `char(n)`            | fixed-length, blank padded |
| `text`                               | variable unlimited length  |

There is no performance difference among these three types in postgres, so
always use text if you don't need any constraints.
[Link](https://www.postgresql.org/docs/current/datatype-character.html)
