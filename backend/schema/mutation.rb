# schema/mutation.rb

require 'graphql'
require './schema/types.rb'
require './schema/mutations/book.rb'
require './models/models.rb'


class MutationType < GraphQL::Schema::Object
  description "The mutation root of this schema"

  field :updateBook, mutation: UpdateBook
  field :deleteBook, mutation: DeleteBook

end

