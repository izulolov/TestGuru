class Admin::BadgesController < Admin::BaseController
  before_action :set_badge, only: %i[show edit update destroy]
  def index
    @badges = Badge.all
  end

  def new
    @badge = Badge.new
  end

  def create
    @badge = current_user.badges.new(badge_params)
    if @badge.save
      redirect_to admin_badges_path, notice: "Success"
    else
      render :new
    end
  end

  def show

  end

  def edit

  end

  def update
    if @badge.update(badge_params)
      redirect_to admin_badges_path, notice: "Badge updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @badge.destroy
    redirect_to admin_badges_path, notice: "Badge deleted successfully."
  end

  private

  def badge_params
    params.require(:badge).permit(:name, :image_url, :rule)
  end

  def set_badge
    @badge = Badge.find(params[:id])
  end
end
