module PubsHelper
  def add_beer_link(name, form)
    link_to_function name do |page|
      beer = render(:partial => 'beer', :locals => { :pub_form => form, :beer => Beer.new })
      page << %{
var new_beer_id = new Date().getTime();
$('#beers_area').append(change_id_of_dynamically_added_field("#{ escape_javascript beer }", new_beer_id) );
}
    end
  end
  
  def lightbox_image_tag(image)
    link_to(
            image_tag(image.attachment.url(:thumb)),
            image.attachment.url(:medium),
            :rel => "lightbox",
            :alt => pub_photo_alt_text(image),
            :title => pub_photo_alt_text(image))      
  end
end
