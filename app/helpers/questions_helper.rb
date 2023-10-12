module QuestionsHelper

  def question_header(question)
    question.persisted? ? "Edit #{title(question)} Question" : "Create New #{title(question)} Question"
  end

  def title(question)
    Test.find_by(id: question.test_id).title
  end
end
