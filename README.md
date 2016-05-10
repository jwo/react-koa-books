# Example App with Koa, React, and Postgres (Sequelize)

I wanted a simple example with Koa (basically express v2), React, and Sequelize
Postgres.

Plenty of examples exist with connections to Mongo, but few with connections to
Postgres that don't execute raw SQL.

## DB Schema and dump

Easy restore is to `psql < pg.sql`. That's what I did. You have authors and
books. Books belong to authors.

### Made With Universal JS Boilerplate
