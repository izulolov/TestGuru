class FeedbacksController < ApplicationController
  
  def new
    @feedback = Feedback.new if user_signed_in?
  end

  def create
    user_signed_in? ? feedback_for_user_who_signed_in : feedback_for_user_who_not_signed_in
  end

  private

  def feedback_params
    params.require(:feedback).permit(:message)
  end

  # Если пользователь залогинен
  def feedback_for_user_who_signed_in
    @feedback = Feedback.new(feedback_params)
    @feedback.user_id = current_user.id
    if @feedback.save
      FeedbacksMailer.new_feedback_logged_in_user(@feedback).deliver_now
      render :success
    else
      redirect_to new_feedback_path, alert: "No success!"
    end
  end

  # Если пользователь не залогинен
  def feedback_for_user_who_not_signed_in
    if FeedbacksMailer.new_feedback_unlogged_in_user(params[:name], params[:email], params[:message]).deliver_now
      render :success
    else
      redirect_to new_feedback_path, alert: "No success!"
    end
  end
end
