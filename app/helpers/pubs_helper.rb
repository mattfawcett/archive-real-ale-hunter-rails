module PubsHelper
  def add_beer_link(name, form)
    link_to_function name do |page|
      beer = render(:partial => 'beer', :locals => { :beer_form => form, :beer => Beer.new })
      page << %{
var new_beer_id = "new_" + new Date().getTime();
$('#beers_area').append("#{ escape_javascript beer }".replace(/new_\\d+/g, new_beer_id) );
}
    end
  end
end
