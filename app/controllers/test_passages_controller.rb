class TestPassagesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show update result gist]

  def show

  end

  def result

  end

  def update
    if params[:answer_ids].blank?
      flash.now[:alert] = "#{t('.failure')}"
    else
      @test_passage.accept!(params[:answer_ids])
    end

    # successfully_passed? а не passed? потому, что пассед закрытый и меняет состояние поле passed в таблице тестпассаж
    if @test_passage.completed?
      BadgeService.new(@test_passage).award_badges if @test_passage.successfully_passed?
      
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
end
