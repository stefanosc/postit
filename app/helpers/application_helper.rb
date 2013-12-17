module ApplicationHelper
  def fix_url(str)
    unless str.nil?
      str.starts_with?("http://") ? str : "http://#{str}"
    end
  end

  def fix_date(date)
    unless date.nil?
      date.strftime("%m/%d/%Y %l:%M%P %Z ")      
    end

    
  end
end
