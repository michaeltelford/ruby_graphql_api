# Ruby GraphQL API

A Ruby GraphQL API example project.

Built using `ruby 2.5.0` and the following gems:

- `rack` gem as the HTTP transport layer
- `graphql` gem as the GraphQL engine
- [`rom` gem](https://rom-rb.org/) as the business logic layer
- `faker` gem as a demo data repository

See the `Gemfile.lock` file for exact gem versioning.

## HTTP Transport Layer

Using `rack` instead of a fully fledged web framework keeps the transport layer light and minimal. With GraphQL there's only one endpoint and two supported HTTP methods/verbs: `GET` and `POST`. The main job `rack` has is to pass the user query to the GraphQL schema. This API tries to be as close to [spec](https://facebook.github.io/graphql/) compliant as possible but this isn't its main aim.

## GraphQL

### GraphQL Field Resolver Lookup

When a GraphQL query is received the schema tries to return a type which has the correct fields for the client to access. Since GraphQL is a strongly typed system we must return plain Ruby objects which match the fields defined in the schema. This is where `rom-rb` comes in. `graphql` will try to resolve a field using the following approaches (in order). 

For example, if the query is:

```
{ 
    post { 
        title 
    } 
}
```

Then the look-up will be:

- `Types::Post#title` - The GraphQL type, `title` field resolver
- `Post#title` - The Ruby object's `title` instance method
- Looking up hash key `:title` or `"title"` - The Ruby object's `[]` instance method

The first to return a `title` value (of type `String`) will be used to resolve and return the data to the client. 

### Placement Of Business Logic

Due to the multiple ways in which to resolve any given field, there is a slight problem in how we decide where the data for each field is resolved. We know from above that the GraphQL type is checked first, followed by the Ruby object/type. A simple solution is to always have the Ruby object match its fields with that of the GraphQL type. But what if our Ruby object comes from a library like ActiveRecord where we don't have as much fine grained control over the objects as we'd like? Say we want to add a new field to our GraphQL API that doesn't match a column in the Database or the ActiveRecord object; In this case we could implement a custom resolver on the GraphQL type and have the field be resolved that way. Problem solved right...? Not really. Because now we have ActiveRecord providing some resolutions and GraphQL resolvers (with custom Ruby code) resolving the rest. How will this look when our API has grown and pulls data from more than just a SQL Database? The project will enivitably become difficult to develop and maintain features on. 

The solution I am advocating is to never use custom GraphQL field resolvers and instead always have the Ruby object match the GraphQL type being returned to the client. To do this we need a Ruby object that isn't tied to any particular datastore, be it a Database or another API etc. 

## rom-rb

`rom-rb` allows us to build simple, plain Ruby objects with fields exactly matching that of the GraphQL types. `rom-rb` allows us to build a [clean architecture](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html) that is datastore agnostic. It provides us with a place to store our business logic which implements our GraphQL API without getting bogged down with implementation details. `rom-rb` essentially provides a thin layer between GraphQL and our datastores, however many different kinds there might be. It provides a separation of concerns which will allow our schema to grow and scale in a manner which is maintainable. 
It also means that all of our data resolution logic is in one place, a layer dedicated to it and nothing else. It's a highly decoupled solution without being overkill in terms of unnecessary abstractation. 

`rom-rb` also provides support lower down for SQL Databases meaning it's an alternative to ActiveRecord. The main difference being that the objects it returns are not tied to the Database, they can be used in isolation as this project demonstrates. 

## Datastores

Most modern API's will pull data from a Database (be it SQL based or otherwise). The type of datastore doesn't matter because they all essentially do the same thing. They model and store data. 

Since the GraphQL schema (and its type system) models the data for us, we only need to be concerned with retrieving the data in this instance. Therefore, the `faker` gem provides us with a way of returning arbitrary but realistic data to the client. 

Obviously, in a real world scenario you'd be writing to the datastore as well as just reading from it. You'd therefore need persistance and `faker` would no longer be sufficient. 

In which case, it wouldn't be difficult to swap out `faker` for SQLite, Postgres or MongoDB. Or all 3! Only the layers below that which `rom-rb` controls would be affected. Since the GraphQL schema isn't changing, the code in its layer doesn't change either. This is the power of 'separation of concerns'. 
