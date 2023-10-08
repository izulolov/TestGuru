class TestsController < ApplicationController
  before_action :find_test, only: %i[show]

  # GET tests#index
  # /tests
  def index
    @tests = Test.all
  end

  # GET tests#show
  # /tests/:id
  def show
    
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end
end
