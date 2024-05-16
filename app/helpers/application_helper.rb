module ApplicationHelper
  def current_year
    Time.now.strftime('%d-%m-%y %H:%M:%S')
  end

  def github_url(name_repo, url_path)
    link_to name_repo, "https://github.com#{url_path}"
  end

  # 2
  def flash_type(type)
    case type
      when 'notice'
        'alert-success'
      when 'alert'
        'alert-warning'
      when 'error'
        'alert-danger'
    end
  end
end
