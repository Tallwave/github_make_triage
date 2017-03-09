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
      new_project_id = create_project 'Bug Tracking', 'Issue tracking and triage board'
      if new_project_id
        create_columns new_project_id, MakeTriage.default_columns
      end
    end

    private
    def create_project(name, description)
      uri = MakeTriage.make_project_uri @owner, @repo, @token
      payload = {
        "name" => name,
        "body" => description
      }
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == "https"
      req = Net::HTTP::Post.new uri.request_uri
      req.content_type = "application/json"
      req.add_field "Accept", "application/vnd.github.inertia-preview+json"
      req.body = payload.to_json
      response = handle_response http.request(req)
      return retrieve_id(response) unless response == false
    end

    def create_columns(project_id, columns)
      columns.each { |column_name| create_column(project_id, column_name) }
    end

    def create_column(project_id, column_name)
      uri = MakeTriage.make_column_uri project_id, @token
      payload = {
        "name" => column_name
      }
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == "https"
      req = Net::HTTP::Post.new uri.request_uri
      req.content_type = "application/json"
      req.add_field "Accept", "application/vnd.github.inertia-preview+json"
      req.body = payload.to_json
      return handle_response http.request(req)
    end

    def handle_response(response)
      error_handler = ErrorHandler.new
      if error_handler.response_has_error response
        error_handler.handle_error error_handler.error_message(response.body), true
        return false
      end
      return response.body
    end

    def retrieve_id(body)
      response_obj = JSON.parse(body)
      response_obj["id"]
    end
  end
end
