class GistsController < ApplicationController
  before_action :set_test_passage, only: %i[create]

  # Создаем гист в гитхаб если всё ок то добавляем гист еще в бд
  def create
    service = GistQuestionService.new(@test_passage.current_question)
    response = service.call
    if service.success?
      create_database_gist(response)
      redirect_to @test_passage, notice: "#{t('.success')} #{view_context.link_to 'GitHub', response.html_url}"
    else
      redirect_to @test_passage, alert: t('.failure')
    end
  end

  private

  def create_database_gist(response)
    Gist.create(question_id: @test_passage.current_question.id,
                gist_url: response.html_url,
                user_id: @test_passage.user_id)
  end

  def set_test_passage
    @test_passage = TestPassage.find(params[:test_passage_id])
  end
end
