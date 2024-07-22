class Admin::TestsController < Admin::BaseController
  before_action :set_tests, only: %i[index update_inline]
  before_action :find_test, only: %i[show edit update destroy start update_inline status]

  def index
    @tests = Test.all
  end
  
  def status
    if @test.can_be_published?
      @test.update(published: !@test.published)
      redirect_to admin_tests_path(@test), notice: @test.published ? "#{ t('.published') }" : "#{ t('.confiscated') }"
    else
      redirect_to admin_tests_path(@test), alert: "Тест не опубликован! Тест должен содержать как минимум один вопрос и один ответ"
    end
  end

  def show

  end

  def new
    @test = Test.new
  end

  def create
    @test = current_user.author_tests.new(test_params)
    if @test.save
      redirect_to admin_test_path(@test), notice: t('.failure')
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @test.update(test_params)
      redirect_to admin_test_path(@test)
    else
      render :edit
    end
  end

  def update_inline
    if @test.update(test_params)
      redirect_to admin_tests_path
    else
      render :index
    end
  end

  def destroy
    @test.destroy
    redirect_to admin_tests_path
  end

  private

  def set_tests
    @tests = Test.all
  end

  def test_params
    params.require(:test).permit(:title, :level, :category_id)
  end

  def find_test
    @test = Test.find(params[:id])
  end
end
