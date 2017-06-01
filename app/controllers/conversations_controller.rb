class ConversationsController < ApplicationController

#ログインしていなければ以下の処理は実行されない 
before_action :authenticate_user!


 # メッセージの全内容を表示
  def index
    @users = User.all
    @conversations = Conversations.all
  end

# メッセージを作成(sender:送り主,recipient:受取人)
  def create
    # 送り主と受取人との間に会話が存在するかどうか?(過去にやりとりがあるかどうか)
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      # ある場合：送り主と受取人の会話内容を取得
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      # ない場合：送り主と受取人の会話を強制的に作成
      @conversation = Conversation.create!(conversation_params)
    end

    redirect_to conversation_messages_path(@conversation)
  end

  private

    # ストロングパラメーターの設定
    def conversation_params
      params.permit(:sender_id, :recipient_id)
    end


end
