require_relative 'test_helper'

# Mock the bit that calls the graphql engine.
class GraphQL
  def exec_schema(query, variables)
    { 'query' => query, 'variables' => variables }
  end
end

# Test the API endpoints.
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
    post '/graphql', Oj.dump(expected), CONTENT_TYPE_JSON
    assert last_response.ok?
    assert_equal expected, Oj.load(last_response.body)
  end

  def test_get_graphql_missing_query
    get '/graphql'
    assert_equal 400, last_response.status
  end

  def test_post_graphql_missing_query
    expected = { "query" => "" }
    post '/graphql', Oj.dump(expected), CONTENT_TYPE_JSON
    assert_equal 400, last_response.status
  end

  def test_graphql_method_not_allowed
    put '/graphql'
    assert_equal 405, last_response.status
  end
end
