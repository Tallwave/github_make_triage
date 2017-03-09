require 'spec_helper'

describe 'Import Integrations:' do
  let (:owner) { "swilliams" }
  let (:repo) { "test-repo" }
  let (:token) { "abcdef" }

  let (:mock_response) {
    mock_file = File.expand_path('../fixtures/project_result.json', __FILE__)
    File.read mock_file
  }

  let (:mock_bad_response) {
    mock_file = File.expand_path('../fixtures/error_response.json', __FILE__)
    File.read mock_file
  }

  it 'creates a project' do
    stub_request(:post, "https://api.github.com/repos/swilliams/test-repo/projects?access_token=abcdef").to_return(body: mock_response)
    stub_request(:post, "https://api.github.com/projects/443424/columns?access_token=abcdef")
    builder = MakeTriage::ProjectBuilder.new(owner, repo, token)
    expect { builder.make() }.to output('').to_stdout
  end

  it 'handles errors gracefully' do
    stub_request(:post, "https://api.github.com/repos/swilliams/test-repo/projects?access_token=abcdef").to_return(body: mock_bad_response, status: 403)
    builder = MakeTriage::ProjectBuilder.new(owner, repo, token)
    expect { builder.make() }.to raise_error SystemExit
  end
end
