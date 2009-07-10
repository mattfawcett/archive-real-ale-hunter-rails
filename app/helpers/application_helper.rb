module ApplicationHelper
  def flash_messages
    messages = []
    %w(notice warning error).each do |msg|
      messages << content_tag(:div, flash[msg.to_sym], :class => "flash #{msg}") unless flash[msg.to_sym].blank?
    end
    messages
  end
  
  def pub_photo_alt_text(image)
    "#{image.name} - uploaded by #{image.user.username} #{distance_of_time_in_words(image.created_at.to_f, Time.now.to_i)} ago"
  end

  def add_beer_link(name, form)
    link_to_function name do |page|
      beer = render(:partial => 'shared/beer', :locals => { :pub_form => form, :visit_form => form, :beer => Beer.new })
      page << %{
var new_beer_id = new Date().getTime();
$('#beers_area').append(change_id_of_dynamically_added_field("#{ escape_javascript beer }", new_beer_id) );
}
    end
  end

end
