class FeedbacksMailer < ApplicationMailer

  def new_feedback_logged_in_user(feedback)
    @last_name = feedback.user.last_name
    @first_name = feedback.user.first_name
    @email = feedback.user.email
    @message = feedback.message
    mail to: first_admin, subject: "Message from #{@last_name} #{@first_name}"
  end

  def new_feedback_for_anonymous_user(feedback)
    @name = feedback[:name]
    @email = feedback[:email]
    @message = feedback[:message]
    mail to: first_admin, subject: "Message from #{@name}"
  end

  private

  def first_admin
    User.where(type: 'Admin').first.email
  end
end
