class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new
  end

  def create
    create_feedback
  end

  private

  def feedback_params
    if user_signed_in?
      params.require(:feedback).permit(:message)
    else
      params.permit(:name, :email, :message)
    end
  end

  def create_feedback
    user_signed_in? ? feedback_for_logged_user : feedback_for_unlogged_user
  end

  def feedback_for_logged_user
    @feedback = current_user.feedbacks.new(feedback_params)
    @feedback.save ? (FeedbacksMailer.new_feedback(@feedback, user_signed_in?).deliver_now;
                      render :success) :
                      redirect_to(new_feedback_path, alert: "Не удалось отправить отзыв.")
  end

  def feedback_for_unlogged_user
    FeedbacksMailer.new_feedback(feedback_params, user_signed_in?).deliver_now ?
                    render(:success) :
                    redirect_to(new_feedback_path, alert: "Не удалось отправить отзыв.")
  end
end
