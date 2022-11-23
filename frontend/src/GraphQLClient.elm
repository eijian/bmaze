--- GraphQLClient.elm

module GraphQLClient exposing (
  makeGraphQLQuery
)

import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet)


graphql_url : String
graphql_url = "http://192.168.11.113:4567/graphql"


makeGraphQLQuery : SelectionSet decodesTo RootQuery 
                 -> (Result (Graphql.Http.Error decodesTo) decodesTo -> msg)
                 -> Cmd msg
makeGraphQLQuery query decodesTo =
    query
        |> Graphql.Http.queryRequest graphql_url
        |> Graphql.Http.send decodesTo
