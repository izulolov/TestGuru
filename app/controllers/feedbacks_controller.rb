class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new
  end

  def create
    user_signed_in? ? create_feedback_for_logged_in_user : create_feedback_for_anonymous_user
  end

  private

  def feedback_params
    if user_signed_in?
      params.require(:feedback).permit(:message)
    else
      params.permit(:name, :email, :message)
    end
  end

  def create_feedback_for_logged_in_user
    @feedback = current_user.feedbacks.new(feedback_params)
    if @feedback.save
      FeedbacksMailer.new_feedback_logged_in_user(@feedback).deliver_now
      render :success
    else
      redirect_to new_feedback_path, alert: "Не удалось отправить отзыв."
    end
  end

  def create_feedback_for_anonymous_user
    if FeedbacksMailer.new_feedback_for_anonymous_user(feedback_params).deliver_now
      render :success
    else
      redirect_to new_feedback_path, alert: "Не удалось отправить отзыв."
    end
  end
end
