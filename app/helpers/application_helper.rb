module ApplicationHelper
  def flash_messages
    messages = []
    %w(notice warning error alert).each do |msg|
      messages << content_tag(:div, flash[msg.to_sym], :class => "flash #{msg}") unless flash[msg.to_sym].blank?
    end
    messages.join.html_safe
  end
  
  def pub_photo_alt_text(image)
    "Uploaded by #{image.user.username} #{distance_of_time_in_words(image.created_at, Time.now)} ago |  #{link_to 'Download Original', image.attachment.url(:original)}"
  end

  def display_username(user)
    "<span title=\"#{h user.username} - #{user.pints} pints\" class=\"dotted-line-username\">#{h user.username}</span>".html_safe
  end

end
