# useful helper methods

# default response headers
DEFAULT_HEADERS = {
    'Content-Type' => 'application/json'
}

# handler helper to build a response
def respond(status, headers: DEFAULT_HEADERS, body: [])
    body = [body] unless body.respond_to? :each
    [status, headers, body]
end
