# schema/types.rb
#

require 'graphql'

module Types

  class BaseObject < GraphQL::Schema::Object
  end

  class BaseEnum < GraphQL::Schema::Enum
  end

  class Book < BaseObject
    description 'Book Object Type'

    field :code, ID, null: false
    field :title, String, null: false
    field :author, String, null: true
    field :date, String, null: true
    field :lead, String, null: true
  end

  class Choice < BaseObject
    description 'Choice Object TYpe'

    field :sceneno, Int, null: false
    field :text, String, null: false
  end

  class Scene < BaseObject
    description 'Scene Object Type'

    field :code, ID, null: false
    field :sceneno, Int, null: false
    field :title, String, null: true
    field :body, String, null: false
    field :body_html, String, null: false
    field :choices, [Choice], null: true
    field :image, Boolean, null: false
  end

  class BooksResult < BaseObject
    description 'Multiple Books Result Object Type'

    field :success, Boolean, null: false
    field :errors, [String], null: false
    field :books, [Book], null: true
  end

  class BookResult < BaseObject
    description 'Book Result Object Type'

    field :success, Boolean, null: false
    field :errors, [String], null: false
    field :books, Book, null: true
  end

  class SceneResult < BaseObject
    description 'Scene Result Object Type'

    field :success, Boolean, null: false
    field :errors, [String], null: false
    field :scene, Scene, null: true
  end

end

#---
