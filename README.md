# README

ROR app that implement graphql query language with a PostgreSQL database.

Add an extension to graphql gem to do dynamic preload of tables (joins/includes) based on the graphql query sent to avid N+1 to the database.

Implement dynamic filters integrating ransack gem to the graphql query language, that way the user is able to filter and sort by any element of the graphql query param.

A seed is included to test the api with graphiql (`http://localhost:3000/graphiql`)

Here are some examples of queries to tests some of the features:
![1.png](public%2F1.png)
![2.png](public%2F2.png)
![3.png](public%2F3.png)
![4.png](public%2F4.png)
