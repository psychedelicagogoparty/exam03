module PhotosHelper

  # プロフィール画像が登録されているかどうかチェックする
  def profile_photo_checker(photo)

    if @photos.find(photo.id).user.image_url
      # 登録されていれな画像をその画像を表示
      return image_tag(@photos.find(photo.id).user.image_url, :size => "40x40")
    else
      # 登録がなければno_imageを表示
      return image_tag("no_image.png", :size => "40x40")
    end

  end

  def photo_checker(photo)
    # binding.pry
    if !photo.photo.model.photo.blank?
        return image_tag(photo.photo,:size => "400x400")
    end

  end

end
