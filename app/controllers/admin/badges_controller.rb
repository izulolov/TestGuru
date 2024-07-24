class Admin::BadgesController < Admin::BaseController

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

  private

  def badge_params
    params.require(:badge).permit(:name, :image_url, :rule)
  end
end
