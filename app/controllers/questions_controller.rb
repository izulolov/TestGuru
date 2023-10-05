class QuestionsController < ApplicationController
  before_action :find_test, only: %i[index create new]
  before_action :find_question, only: %i[show]

  def index
    render inline: 'Вопросы теста: <%= @test.questions.pluck(:body) %>'
  end

  def show
    
  end

  def new

  end

  def create
    @test.questions.create!(question_params)
    redirect_to tests_path
  end

  def destroy
    question = Question.find(params[:id])
    question.destroy
    redirect_to tests_path
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
end
