module ApplicationHelper
  def flash_messages
    messages = []
    %w(notice warning error).each do |msg|
      messages << content_tag(:div, flash[msg.to_sym], :class => "flash #{msg}") unless flash[msg.to_sym].blank?
    end
    messages
  end

end
