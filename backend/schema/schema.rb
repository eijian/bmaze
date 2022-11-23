# schema/schema.rb
#

require 'graphql'
require './schema/query.rb'
require './schema/mutation.rb'

class BmazeSchema < GraphQL::Schema

  query QueryType
  mutation MutationType
  
end
