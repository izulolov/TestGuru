class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show update result gist]
  # Добавляем проверку на истечение времени перед показом и обновлением теста
  before_action :check_time, only: %i[show update]

  def show
    # Если время истекло, это будет обработано в before_action :check_time
  end

  def result
    # Страница результатов
  end

  def update
    params[:answer_ids].blank? ? flash.now[:alert] = "#{t('.failure')}" : @test_passage.accept!(params[:answer_ids])
    
    if @test_passage.completed?
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
  
  # Добавляем метод для проверки истечения времени
  def check_time
    return unless @test_passage.test.has_timer?
    
    if @test_passage.time_over?
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage), alert: t('.time_over')
    end
  end
end
