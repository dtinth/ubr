
require 'rest-client'
require 'json'

module Ubr
  class API
    def initialize
      token = File.read(File.expand_path('~/.ubr')).strip
      @client = RestClient::Resource.new('https://api.uber.com/v1',
        headers: {
          authorization: "Bearer #{token}",
          content_type: 'application/json'
        }
      )
    end
    def get(path, params={})
      parse_response @client[path].get(params: params)
    end
    def post(path, params={})
      parse_response @client[path].post(params.to_json)
    end
    def parse_response(response)
      API.parse_response(response)
    end
    def self.parse_response(response)
      JSON.parse response, symbolize_names: true
    end
    def self.authorize(client_id:, code:, secret:, redirect_uri:)
      client = RestClient::Resource.new('https://login.uber.com/oauth/token')
      parse_response client.post(
        client_secret: secret,
        client_id: client_id,
        grant_type: 'authorization_code',
        redirect_uri: redirect_uri,
        code: code,
      )
    end
  end
end
