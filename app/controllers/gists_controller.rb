class GistsController < ApplicationController
  before_action :set_test_passage, only: %i[create]

  # Создаем гист в гитхаб если всё ок то добавляем гист еще в бд
  def create
    create_github_gist
    if @result.success?
      create_database_gist
      redirect_to @test_passage, notice: "#{t('.success')} #{view_context.link_to 'GitHub', @response.html_url}"
    else
      redirect_to @test_passage, alert: t('.failure')
    end
  end

  private

  def create_github_gist
    @result = GistQuestionService.new(@test_passage.current_question)
    @response = @result.call
  end

  def create_database_gist
    Gist.create(question_id: @test_passage.current_question.id,
                gist_url: @response.html_url,
                user_id: @test_passage.user_id)
  end

  def set_test_passage
    @test_passage = TestPassage.find(params[:test_passage_id])
  end
end
