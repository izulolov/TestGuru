module ApplicationHelper

  def current_year
    "Дата и Время #{Time.now.strftime("%d-%m-%y %H:%M:%S")}"
  end

  def github_url(name_repo, url_path)
    link_to name_repo, "https://github.com#{url_path}"
  end

  # 2
  def flash_message
    content_tag :p, flash[:alert]
  end
end
