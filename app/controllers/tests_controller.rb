class TestsController < ApplicationController
  before_action :find_test, only: %i[show edit update destroy]

  # GET tests#index
  # /tests
  def index
    @tests = Test.all
  end

  # GET tests#show
  # /tests/:id
  def show

  end

  # GET tests#new
  # /tests/new
  def new
    @test = Test.new
  end

  # POST tests#create
  # /tests
  def create
    @test = Test.new(test_params)

    if @test.save
      redirect_to @test
    else
      render :new
    end
  end

  # GET tests#edit
  # /tests/:id/edit
  def edit
    
  end

  # PUT tests#update
  # /tests/:id
  def update
    if @test.update(test_params)
      redirect_to @test
    else
      render :edit
    end
  end

  # questions#destroy
  # DELETE tests/:id
  def destroy
    @test.destroy
    redirect_to tests_path
  end

  private

  def test_params
    params.require(:test).permit(:title, :level, :category_id, :user_id)
  end

  def find_test
    @test = Test.find(params[:id])
  end
end
