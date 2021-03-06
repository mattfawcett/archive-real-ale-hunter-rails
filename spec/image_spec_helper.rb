module ImageSpecHelper
  def new_image(attrs = {})
    Image.new(valid_image_attributes(attrs)) do |image|
      # Remove any paperclip styles specified so as not to invoke ImageMagick
      image.attachment.instance_eval { @styles = {} }
      image.attachment = File.new("#{Rails.root}/app/assets/images/clock.gif")
    end
  end
  
  def create_image(attrs = {})
    new_image(attrs).tap do |image|
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
