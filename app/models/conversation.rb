class Conversation < ActiveRecord::Base

  # 会話の送り手がユーザーモデルから参照できるようにアソシエーションを設定
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  # 会話の受け手がユーザーモデルから参照できるようにアソシエーションを設定
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'
  # 会話は複数のメッセージを所有 会話が削除されたらメッセージも自動的に削除
  has_many :messages, dependent: :destroy
  # 送り手と受け手の重複を許可しない
  validates_uniqueness_of :sender_id, scope: :recipient_id
  # 送り手と受け手の組み合わせでチェックを行う
  scope :between, -> (sender_id,recipient_id) do
    where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND  conversations.recipient_id =?)", sender_id,recipient_id, recipient_id, sender_id)
  end

  def target_user(current_user)
    if sender_id == current_user.id
      User.find(recipient_id)
    elsif recipient_id == current_user.id
      User.find(sender_id)
    end
  end
end
