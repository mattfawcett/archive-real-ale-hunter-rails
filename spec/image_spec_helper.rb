module ImageSpecHelper
  def new_image(attrs = {})
    Image.new(valid_image_attributes(attrs)) do |image|
      # Remove any paperclip styles specified so as not to invoke ImageMagick
      image.attachment.instance_eval { @styles = {} }
      image.attachment = StringIO.open('Test Attachment')
    end
  end
  
  def create_image(attrs = {})
    returning new_image(attrs) do |image|
      image.save!
    end
  end
  
  def valid_image_attributes(attrs = {})
    { :name => 'Photo of the Grove', 
      :pub => Pub.make,
      :user => User.make(:username => "PhotoMan")
    }.merge(attrs)
  end
end
