class Relationship < ActiveRecord::Base
  #Userモデルに対して外部キー follower_idで紐付け
  belongs_to :follower, class_name: "User"
  #Userモデルに対して外部キー followed_idで紐付け 
  belongs_to :followed, class_name: "User"
end
