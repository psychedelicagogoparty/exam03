class Message < ActiveRecord::Base
  # メッセージモデルはユーザモデルや会話モデルに紐づく
  # それぞれのひも付きがされた状態でしかメッセージを作成することはありえない

  belongs_to :conversation
  belongs_to :user

  # 会話の内容,会話のid,userのidが空でないかどうかをチェック
  validates_presence_of :body, :conversation_id, :user_id

  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end

end
