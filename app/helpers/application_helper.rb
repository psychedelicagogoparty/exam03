module ApplicationHelper

    def profile_img(user)

      #carrierwaveで画像がアップロードされていた場合(user.avatarに値がある場合)その画像を表示
      return image_tag(user.avatar, alt: user.name, :size => "100x100", class: "user_photo")  if user.avatar?
      # return image_tag(user.image_url, alt: user.name)  if user.avatar?

      unless user.provider.blank?
        img_url = user.image_url
      else
        img_url = 'no_image.png'
      end
      image_tag(img_url, alt: user.name, :size => "100x100", class: "nouser_photo")

      # image_tag(user.avatar, alt: user.name, :size => "20x20")
    end

    def contribution_time(time)

      # 現在時刻と投稿日の差分を取得
      conttime_diff = (Time.now - time).abs
      if conttime_diff < 86400 #１日より短い
        conttime_diff_hour = Time.now.hour - time.hour
        # binding.pry
        if conttime_diff_hour == 0 #差分が1時間未満
          # binding.pry
          return "#{Time.now.min - time.min}分前"
        else #差分が一時間以上
          # binding.pry
          return "#{conttime_diff_hour.abs}時間前"
        end
      else
        #１日以上の場合は差分を一日分の秒数で割って表示
        conttime_diff_day = (conttime_diff / 86400).round
        return "#{conttime_diff_day}日前"
      end
    end

  #showアクションの代替
  def comment_form(photo_id)
    @photo = photo_id
    @comment = photo_id.comments.build
    @comments = photo_id.comments
    @comment_form_number = 1
  end

end


module ActionView
  module Helpers
    module FormHelper

      def error_messages!(object_name, options = {})
        resource = self.instance_variable_get("@#{object_name}")
        return '' if !resource || resource.errors.empty?

        messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
        #binding.pry

        html = <<-HTML
          <div class="alert alert-danger">
            <ul>#{messages}</ul>
          </div>
        HTML

        html.html_safe
      end

      def error_css(object_name, method, options = {})
        resource = self.instance_variable_get("@#{object_name}")
        return '' if resource.errors.empty?

        resource.errors.include?(method) ? 'has-error' : ''
      end
    end

    class FormBuilder
      def error_messages!(options = {})
        @template.error_messages!(@object_name, options.merge(object: @object))
      end

      def error_css(method, options = {})
        @template.error_css(@object_name, method, options.merge(object: @object))
      end
    end
  end
end
