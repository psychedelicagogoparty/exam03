class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  #UserクラスをPhotoクラスへ紐付けしユーザーを削除すると当該のPhotoカラムを削除する
  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Userモデルが複数のrelationshipを持つ
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  # Relationshipモデルに対してreverse_relationshipsという紐付けを定義
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy

  # UserモデルがRelationshipモデルを介して複数のUserを持つ
  #
  has_many :followed_users, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable

  mount_uploader :avatar,PhotoUploader  #アップローダーの設定

  validates :name, :email, presence: true #バリデーションの設定


  #指定のユーザをフォローする
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  #フォローしているかどうかを確認する
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

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
