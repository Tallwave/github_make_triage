require "open-uri"

module MakeTriage
  def self.project_url
    "https://api.github.com/repos/%s/%s/projects?access_token=%s"
  end

  def self.column_url
    "https://api.github.com/projects/%s/columns?access_token=%s"
  end

  def self.make_project_url(*args)
    url_format = MakeTriage.project_url
    url_format % args
  end

  def self.make_column_url(*args)
    url_format = MakeTriage.column_url
    url_format % args
  end

  def self.make_project_uri(owner, repo, token)
    URI.parse MakeTriage.make_project_url(owner, repo, token)
  end

  def self.make_column_uri(project_id, token)
    URI.parse MakeTriage.make_column_url(project_id, token)
  end

  def self.turn_options_into_querystring(options)
    querystring = ''
    options.each do |k, v|
      escaped_k, escaped_v = URI::encode(k), URI::encode(v)
      querystring += "#{escaped_k}=#{escaped_v}&"
    end
    querystring.chop
  end
end
