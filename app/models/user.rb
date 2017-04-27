class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  #UserクラスをPhotoクラスへ紐付けしユーザーを削除すると当該のPhotoカラムを削除する
  has_many :photos, :dependent => :delete_all

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable

  mount_uploader :avatar,PhotoUploader  #アップローダーの設定

  validates :name, :email,presence: true #バリデーションの設定

  #ランダムなuidを作成するメソッド
  def self.create_unique_string
    SecureRandom.uuid
  end

  # update_with_passwordのオーバーライド
  def update_with_password(params, *options)
    #ユーザーテーブルのproviderカラムの中身が空かどうか
    if provider.blank?
      # binding.pry
      super
    else
      params.delete :current_password
      # binding.pry
      update_without_password(params, *options)
    end
  end


  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
      user = User.find_by(email: auth.info.email)

      unless user
         user = User.new(
              name:     auth.extra.raw_info.name,
              provider: auth.provider,
              uid:      auth.uid,
              email:    auth.info.email ||= "#{auth.uid}-#{auth.provider}@example.com",
              image_url:   auth.info.image,
              password: Devise.friendly_token[0, 20]
             )
             user.skip_confirmation!
             user.save(validate: false)
      end
      user
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource = nil)
  user = User.find_by(provider: auth.provider, uid: auth.uid)

    unless user
      user = User.new(
          name:     auth.info.nickname,
          image_url: auth.info.image,
          provider: auth.provider,
          uid:      auth.uid,
          email:    auth.info.email ||= "#{auth.uid}-#{auth.provider}@example.com",
          password: Devise.friendly_token[0, 20]
      )
      user.skip_confirmation!
      user.save
    end
    user
  end

end
