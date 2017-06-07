class Photo < ActiveRecord::Base
  #アソシエーションの設定
  belongs_to :user
  #写真が削除されたらコメントも同時に削除する
  has_many :comments, dependent: :destroy

  # validates :name, :content, :photo, presence: true #バリデーションの設定(旧)
  validates :name, :content, presence: true #バリデーションの設定
  mount_uploader :photo,PhotoUploader  #carrierwaveの設定
end
