module ApplicationHelper
  def fix_url(str)
    unless str.nil?
      str.starts_with?("http://") ? str : "http://#{str}"
    end
  end

  def fix_date(date)
    unless date.nil?
      if logged_in? and !current_user.time_zone.blank?
        date = date.in_time_zone(current_user.time_zone)
      end
      date.strftime("%m/%d/%Y %l:%M%P %Z")      
    end

    
  end
end
