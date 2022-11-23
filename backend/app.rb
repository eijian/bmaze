#!/usr/bin/ruby
#
# app.ruby

require 'sinatra'
require 'rack/contrib'
require 'sinatra/json'
require './schema/schema.rb'
require './models/models.rb'

class BmazeApp < Sinatra::Base
  use Rack::PostBodyContentTypeParser

  post '/graphql' do
    puts "QS:#{params['query']}"
    ret = BmazeSchema.execute(
      params['query'],
      variables: params['variables'],
      context: { current_user: nil },
    )
    json ret
  end

  options '/graphql' do
    puts "QS:#{params['query']}"
    ret = BmazeSchema.execute(
      params['query'],
      variables: params['variables'],
      context: { current_user: nil },
    )
    json ret
  end

end

def main
  Book.shelf("/Users/eiji/project/bmaze/backend/test")
  Image.set_dir("/Users/eiji/project/bmaze/backend/test")
  
  #BmazeApp.run! :host => 'localhost', :port => 4567
  BmazeApp.run! :bind => '192.168.11.113', :port => 4567  
end

main

#
