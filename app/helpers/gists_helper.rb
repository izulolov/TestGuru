module GistsHelper

  def crop_question_body(body)
    body.chars.count >= 25 ? body.slice(0, 25) : body
  end
end
