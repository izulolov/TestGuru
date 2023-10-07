class QuestionsController < ApplicationController
  before_action :find_test, only: %i[index new create]
  before_action :find_question, only: %i[show destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  # question#index
  # GET /tests/:test_id/questions
  def index
    @questions = @test.questions
  end

  # questions#show
  # GET /tests/:test_id/questions/:id
  def show

  end

  # questions#new
  # GET /tests/:test_id/questions/new
  def new

  end

  # questions#create
  # POST /tests/:test_id/questions
  def create
    question = @test.questions.new(question_params)
    if question.save
      redirect_to test_questions_path, status: :see_other
    else
      render plain: question.errors.inspect
    end
  end

  # questions#destroy
  # DELETE /tests/:test_id/questions/:id
  def destroy
    @question.destroy
    redirect_to root_path
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
