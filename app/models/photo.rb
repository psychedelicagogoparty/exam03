class Photo < ActiveRecord::Base
  belongs_to :user
    validates :name, :content, :photo, presence: true #バリデーションの設定
    mount_uploader :photo,PhotoUploader  #carrierwaveの設定
end
