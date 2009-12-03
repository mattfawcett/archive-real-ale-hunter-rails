module PubsHelper
  def lightbox_image_tag(image)
    link_to(
            image_tag(image.attachment.url(:thumb), 
            :alt => pub_photo_alt_text(image)),
            image.attachment.url(:medium),
            :rel => "lightbox",
            :title => h(pub_photo_alt_text(image)))
  end
end
