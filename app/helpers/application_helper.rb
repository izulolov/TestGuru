module ApplicationHelper

  def current_year
    "Дата и Время #{Time.now.strftime("%d-%m-%y %H:%M:%S")}"
  end
end
