class FeedbacksMailer < ApplicationMailer
  
  def new_feedback_logged_in_user(feedback)
    @last_name = feedback.user.last_name
    @first_name = feedback.user.first_name
    @email = feedback.user.email
    @message = feedback.message
    mail to: User.where(type: 'Admin').first.email, subject: "Message from #{@last_name} #{@first_name}"
  end

  def new_feedback_unlogged_in_user(name, email, message)
    @name = name
    @email = email
    @message = message
    mail to: User.where(type: 'Admin').first.email, subject: "Message from #{@name}"
  end
end
