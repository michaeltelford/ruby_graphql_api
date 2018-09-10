# useful helper methods

CONTENT_TYPE_JSON = {
    'Content-Type' => 'application/json'
}

# handler helper to build a response
def respond(status, headers: {}, body: [])
    body = [body] unless body.respond_to? :each
    [status, headers, body]
end
