class GitHubClient

  ROOT_ENDPOINT = 'https://api.github.com'
  ACCESS_TOKEN = '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'
  
  def initialize
    @http_client = setup_http_client
  end

  def create_gist(params)

    @http_client.post('/gists') do |request|
      request.headers['Accept'] = 'application/vnd.github+json'
      request.headers['Authorization'] = "Bearer #{ENV['GITHUB_GIST_ACCESS_TOKEN']}"
      request.headers['X-GitHub-Api-Version'] = '2022-11-28'
      request.body = params.to_json
    end
  end

  private

  def setup_http_client
    Faraday.new(url: ROOT_ENDPOINT)
  end
end
