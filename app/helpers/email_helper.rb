module EmailHelper
  def email_image_tag(image, **options)
    image_tag image.url, **options
  end
end