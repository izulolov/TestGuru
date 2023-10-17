module QuestionsHelper

  def question_header(question)
    question.persisted? ? "Edit #{question.test.title} Question" : "Create New #{question.test.title} Question"
  end

  def title(question)
    Test.find_by(id: question.test_id).title
  end
end
