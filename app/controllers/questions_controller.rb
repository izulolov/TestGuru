class QuestionsController < ApplicationController
  before_action :find_test, only: %i[index new create]
  before_action :find_question, only: %i[show]

  def index
    render inline: 'Вопросы теста: <%= @test.questions.pluck(:body) %>'
  end

  def show
    render inline: 'Вопрос: <%= @question.body %>'
  end

  def new

  end

  def create
    @question = @test.questions.create!(question_params)
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
