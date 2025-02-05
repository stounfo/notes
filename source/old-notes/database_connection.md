---
related:
    - "[[Database]]"
---

# Database connection

#todo summarize the article for all application connections (nginx/db/queue etc)

## Database connections issues

Database management faces challenges with connection handling. This section
outlines these issues.

#### Creating connection issue

What happens when your application connects to the database to perform a
database operation:

1. The application uses a database driver (for example: psycopg) to open a
   connection.
2. A network socket is opened to connect the application and the database.
3. The user is authenticated.
4. The operation completes and the connection may be closed.
5. The network socket is closed.

The opening and closing of the connection and the network socket ==is a very
expensive multistep process that requires computing resources.==

Pooling is a way to reduce the cost of opening and closing connections by
maintaining a “pool” of open connections that can be passed from database
operation to database operation as needed.

#### Connection limits issue

==Databases cannot handle an infinite number of connections to it== and ==have a
limit on the number== of active connections.

Mostly ==the limit of active connections the database can handle depends on the
type of parallelism== using by the database.

Globally, there are three types of parallelisms:

1. ==Process-based==. Databases examples: PostgreSQL
2. ==Thread-based==. Database examples: MySQL
3. ==non-blocking I/O== (like async in python). Database examples: Redis,
   MongoDB (but it also uses threads)

Modern computers can manage a few hundred to several thousand active processes
or threads. Therefore, ==process-based or thread-based databases can handle only
a few hundred== active connections, while ==non-blocking I/O databases can
manage tens of thousands== of connections simultaneously.

Usually, ==application server give to every client its own connection to the
database== (one connection per request). So if the application server handle
tens of thousands clients at a time, the database (even non-blocking I/O) ==may
not be able to handle that many connections.==

Pooling helps to limit the number of active connections.

## Connection pooling

The issues described above explain why connection pooling is necessary.
Globally, there are several ways to create connections pooling to the database.

#### Application-level pooling

Every instance of an application ==creates its own pool of connections==. For
instance, It is the main approach for MongoDB.

Cons:

- If the application has a dynamic number of instances, application developers
  must manage the maximum number of connections in the pool for every
  instance, either at runtime or during startup.

#### Middleware pooling

There is a proxy pooling server like PgBouncer or Odyssey. ==Every instance of
application borrow a free connection== for each request. For instance, it is a
popular approach for PostgreSQL.

Cons:

- This proxy server is a potential point of failure in the infrastructure.

## Diving into specific databases and their connection strategies

1. PostgreSQL:
    - **Connection Handling**: Uses a process-based model where each connection
      is handled by a separate server process.
    - **Connection limit**: around 100 active connections.
    - **Connection Pooling**: Often requires external connection poolers like
      PgBouncer or Odyssey to manage connection overhead efficiently.
      Application-level pooling can also be used, but it requires careful
      management of the maximum number of connections for each application
      pooler.
2. MySQL:
    - **Connection Handling**: Follows a thread-based model, creating a new
      thread for each client connection.
    - **Connection limit**: several hundred to a few thousand connections.
    - **Connection Pooling**: can benefit from both application-level pooling
      and middleware solutions. While it does not require external connection
      poolers as critically as PostgreSQL, using poolers like ProxySQL can help
      in managing connections and improving performance.
3. MongoDB:
    - **Connection Handling**: operates with a process-based approach at a high
      level, but is more accurately described as using a thread-based model
      within this process.
    - **Connection limit**: Can handle several thousand connections. But it's
      more optimized for a larger number of connections than MySQL.
    - **Connection Pooling**: Primarily relies on client-side pooling, managed
      by the MongoDB drivers.
4. **Redis**:
    - **Connection Handling**: Redis uses a single-threaded, event-driven model.
      It handles all commands in a non-blocking fashion, making it efficient for
      operations with high I/O wait times.
    - **Connection limit**: Can support up to tens of thousands of simultaneous
      connections.
    - **Connection Pooling**: Given its non-blocking nature, Redis benefits less
      from connection pooling compared to relational databases. However,
      client-side connection pooling can still be useful in reducing connection
      overhead, especially in high-throughput scenarios.
