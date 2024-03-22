class QuestionsController < ApplicationController
  
  before_action :find_test, only: %i[index new create]
  before_action :find_question, only: %i[show destroy edit update]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    @questions = @test.questions
  end

  def show

  end

  def new
    @question = @test.questions.new
  end

  def edit

  end

  def create
    question = @test.questions.new(question_params)
    if question.save
      redirect_to test_questions_path, status: :see_other
    else
      render plain: question.errors.inspect
    end
  end

  def destroy
    @question.destroy
    redirect_to test_path(@question.test)
  end

  def update
    if @question.update(question_params)
      redirect_to test_path(@question.test), status: :see_other
    else
      render :edit
    end
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:body)
  end

  def rescue_with_question_not_found
    render plain: 'Вопрос не найден!'
  end
end
