require "ostruct"
require "faker"
require "securerandom"

# Provides an entrypoint into the application defined types by firstly
# initialising them and secondly defining their structure.
# We do this in two separate steps to avoid cyclic dependancies between
# types that require each other prior to one of them being initialised.
# It also means we only have one file to require in schema.rb to load in all
# of our application's types.
# Any new types being added should be listed below.
module Types
    class Post < GraphQL::Schema::Object; end
    class Comment < GraphQL::Schema::Object; end
end

require_relative "post"
require_relative "comment"
