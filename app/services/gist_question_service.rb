class GistQuestionService

  def initialize(question, client: nil)
    @question = question
    @test = @question.test
    @client = client || Octokit::Client.new(access_token: "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")
  end

  def call
    @client.create_gist(gist_params)
  end

  private

  def gist_params
    { description: "A question about #{@test.title} from TestGuru",
      public: false,
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
