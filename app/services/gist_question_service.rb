class GistQuestionService

  def initialize(question, client: nil)
    @question = question
    @test = @question.test
    @client = client || Octokit::Client.new(access_token: ENV['GITHUB_GIST_ACCESS_TOKEN'])
  end

  def call
    @client.create_gist(gist_params)
  end

  def success?
    @client.last_response.status == 201
  end

  private

  def gist_params
    { description: I18n.t('.services.gist.descreption', title: @test.title),
      public: true,
      files: { 'test-guru-question.txt':
        { content: gist_content }
      }
    }
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end
end


=begin
 params = {
   "description": "The discription for the gist",
   "public": true,
  "files": {
    "file1.txt": {
       "content": "String file contents"
    }
  }
}
=end
