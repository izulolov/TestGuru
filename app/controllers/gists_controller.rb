class GistsController < ApplicationController
  before_action :set_test_passage, only: %i[create]


  def create
    result = GistQuestionService.new(@test_passage.current_question)
    response = result.call
    flash_options = if result.success?
      { notice: "#{t('.success')} #{view_context.link_to 'GitHub', response.html_url}" }
    else
      { alert: t('.failure') }
    end

    redirect_to @test_passage, flash_options
  end
  
  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:test_passage_id])
  end
end
