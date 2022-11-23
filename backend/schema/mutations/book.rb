# schema/mutations/book.rb

require 'graphql'
require './schema/types.rb'
require './models/models.rb'

private def success(book)
  {
    success: true,
    errors: [],
    book: book
  }
end

private def error(errores)
  {
    success: false,
    errors: errors,
    book: nil
  }
end

class UpdateBook < GraphQL::Schema::Mutation
  description 'update book'
  argument :code, ID, required: true
  argument :title, String, required: true
  argument :author, String, required: false
  argument :date, String, required: false
  argument :lead, String, required: false
end

class DeleteBook < GraphQL::Schema::Mutation
  description 'delete book'

  argument :code, ID, required: true
end



