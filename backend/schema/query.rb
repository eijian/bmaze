# schema/query.rb

require 'graphql'
require './schema/types.rb'
require './models/models.rb'

class QueryType < GraphQL::Schema::Object
  description "The query root of this schema"

  field :books, [Types::Book], null: false do
    argument :title, String, required: false
    description 'get all books'
  end

  def books(**arg)
    if arg.empty?
      Book.all
    else
      Book.find(arg[:title])
    end
  end

  field :book, Types::Book, null: false do
    argument :code, ID, required: true
    description 'get book'
  end

  def book(**arg)
    Book.get(arg[:code])
  end

  field :scene, Types::Scene, null: false do
    argument :code, String, required: true
    argument :sceneno, Int, required: true
    description 'get scene'
  end

  def scene(**arg)
    Book.scene(arg[:code], arg[:sceneno])
  end

end

