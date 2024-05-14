module QuestionsHelper

  def question_header(question)
    question.persisted? ? I18n.t('.admin.questions.edit.header') : I18n.t('.admin.questions.new.header')
  end
end
