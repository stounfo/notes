---
related: "[[SQL]]"
---

# DDL, DML, DCL, TCL

DDL statements are used to define, modify, or delete the structure of database
objects but not manipulate the data within those objects. Commands include:

- `CREATE` for creating new tables or databases.
- `ALTER` for modifying existing tables.
- `DROP` for deleting tables or databases.
- `TRUNCATE` for deleting data within a table but not the table itself.

## DML (Data Manipulation Language)

DML statements are used to manipulate the data within the database structures.
Commands include:

- `SELECT` for retrieving data from one or more tables.
- `INSERT` for adding new records to tables.
- `UPDATE` for modifying existing records.
- `DELETE` for removing records from tables.

## DCL (Data Control Language)

DCL statements are used to control access to data within the database. Commands
include:

- `GRANT` for giving specific privileges to users or roles.
- `REVOKE` for removing specific privileges from users or roles.

## TCL (Transaction Control Language)

TCL commands deal with the transaction operations within databases. Commands
include:

- `COMMIT` for saving all the transactions to the database.
- `ROLLBACK` for undoing transactions.
- `SAVEPOINT` for creating points within transactions to which you can later
  roll back.
- `SET TRANSACTION` for naming transactions.
