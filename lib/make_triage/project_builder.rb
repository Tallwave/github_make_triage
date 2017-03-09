# Copyright (c) 2017 Tallwave

require "net/http"
require "json"

module MakeTriage
  class ProjectBuilder

    attr_accessor :outputter

    def initialize(owner, repo, token = nil)
      @owner = owner
      @repo = repo
      @token = token
    end

    def make
      create_project 'Bug Tracking'

    end

    private
    def create_project(name, description, next)
      error_handler = ErrorHandler.new
      uri = MakeTriage.make_project_uri @owner, @repo, @token
      payload = {
        "name" => name,
        "body" => description
      }
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == "https"
      req = Net:HTTP::Post.new uri.request_uri
      req.content_type = "application/json"
      req.body = payload.to_json
      handle_response http.request(req)
    end

    def create_columns(columns)
    end

    def handle_response(response)
      error_handler = ErrorHandler.new
      if error_handler.response_has_error response
        error_handler.handle_error error_handler.error_message(response.body), true
      end
    end
  end
end
