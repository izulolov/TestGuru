class FeedbacksMailer < ApplicationMailer

  def new_feedback(feedback, logged_in)
    if logged_in
      @last_name = feedback.user.last_name
      @first_name = feedback.user.first_name
      @email = feedback.user.email
      @message = feedback.message
      mail to: first_admin, subject: "Message from #{@last_name} #{@first_name}"
    else
      @name = feedback[:name]
      @email = feedback[:email]
      @message = feedback[:message]
      mail to: first_admin, subject: "Message from #{@name}"
    end
  end

  private

  def first_admin
    User.where(type: 'Admin').first.email
  end
end
