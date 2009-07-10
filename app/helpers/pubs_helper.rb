module PubsHelper
  def lightbox_image_tag(image)
    link_to(
            image_tag(image.attachment.url(:thumb)),
            image.attachment.url(:medium),
            :rel => "lightbox",
            :alt => pub_photo_alt_text(image),
            :title => pub_photo_alt_text(image))      
  end
end
