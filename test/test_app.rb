require_relative 'test_helper'

# we mock the bit that calls the graphql engine
class GraphQL
  def exec_schema(query, variables)
    { 'query' => query, 'variables' => variables }
  end
end

# test the api endpoints
class SinatraAppTest < Minitest::Test
  include Rack::Test::Methods

  CONTENT_TYPE_JSON = { 'Content-Type' => 'application/json' }

  def app
    App
  end

  def test_not_found
    get '/'
    assert_equal 404, last_response.status
  end

  def test_health
    get '/health'
    assert_equal 204, last_response.status
  end

  def test_get_graphql
    expected = { "query" => "hello", "variables" => "world" }
    get '/graphql?query=hello&variables=world'
    assert last_response.ok?
    assert_equal expected, Oj.load(last_response.body)
  end

  def test_post_graphql
    expected = { "query" => "hello", "variables" => "world" }
    # puts "TEST DATA: #{rack_input(expected)['rack.input']}"
    post '/graphql', CONTENT_TYPE_JSON, rack_input(expected)
    puts last_response.status
    assert last_response.ok?
    assert_equal expected, Oj.load(last_response.body)
  end

  def test_get_graphql_bad_request
    #
  end

  def test_post_graphql_bad_request
    #
  end

  def test_graphql_method_not_allowed
    put '/graphql'
    assert_equal 405, last_response.status
  end
end
