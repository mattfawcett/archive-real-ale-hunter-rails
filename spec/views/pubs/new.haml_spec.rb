require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/pubs/new.haml" do
  include PubsHelper
  
  before(:each) do
    assigns[:pub] = @pub = Pub.new
  end

  it "should render edit form with a field for name" do
    render "/pubs/new.haml"
    response.should have_tag("form[action=#{pubs_path}][method=post]") do
      with_tag('input#pub_name[name=?]', "pub[name]")
      with_tag('textarea#pub_description[name=?]', "pub[description]")
    end
  end
end