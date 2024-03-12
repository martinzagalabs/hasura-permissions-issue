# Hasura Issue


## Problem Combining Inherited Roles and Root fields Permissions

When trying to have custom business logic for a table and at the same time 
you want to enable select_by_pk without restrictions one option (the one this repo address) is to
combine the features of Inherited Roles and Root fields Permissions.

The idea is to create a role that only applies to a select_by_pk query and a role that only applies to a select query

However it seems that when Hasura combines this roles to compile the permission query is ignoring (not removing) 
the roles that DONT apply to that graphql query, therefore with this scenario the more open role applies and the client has full access

This repo has the necessary configs to reproduce the issue

## Reproduction Steps

### Steps to Install Dependencies
To set up your local environment, please follow the steps below:

1. Open your terminal.
2. Run the script to rebuild your local Hasura instance:
    ```bash
    sh rebuild-local-hasura.sh
    ```
   
This will create the `hasura_db_local` and `hasura_local` containers for PosgreSQL and Hasura Engine

## Steps to Reproduce

To verify the installation and see the data retrieval in action, execute the following GraphQL query:

```graphql
query Example {
  products_by_pk(id: "da97e554-7e88-4d20-879b-4c7104f539da") {
    id
    name
    semi_public_c
  }
  products {
    id
    name
    # This next 2 properties should not be available
    semi_public_c
    semi_public_d
  }
}
```

## Expected Results
The products_by_pk query should return an object with the specific fields populated.

The products query should return an array of objects, but only 3 objects should be visible based 
on the visibility rules defined. Each object can include the id, name but should never include 
semi_public_c, and semi_public_d fields.
