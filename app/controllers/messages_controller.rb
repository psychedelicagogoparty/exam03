class MessagesController < ApplicationController
# メッセージコントローラ：会話毎に紐づいて表示させる
# - 一覧表示＆新規作成フォーム（indexアクション）
# - 新規登録（createアクション）

# あらかじめ会話のどの会話なのかを取得しておく
before_action do
  @conversation = Conversation.find(params[:conversation_id])
end

  def index
    #会話に紐づいたメッセージを取得
    @messages = @conversation.messages

    # メッセージの数が10以上かどうか
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end

    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end

    if @messages.last
      if @messages.last.user_id != current_user.id
       @messages.last.read = true
      end
    end

    @message = @conversation.messages.build
  end

  def create
    # 会話に紐づくメッセージを作成
    @message = @conversation.messages.build(message_params)
    # メッセージの作成に成功すると会話に紐づいたメッセージ一覧にリダイレクト
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private
    def message_params
      params.require(:message).permit(:body,:user_id)
    end

end
