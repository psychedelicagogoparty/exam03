class CommentsController < ApplicationController
    before_action :set_comment, only: [:show, :edit, :update, :destroy]

    def create
      # Photoをパラメータの値から探し出し,Photoに紐づくcommentsとしてbuildします。
      @comment = current_user.comments.build(comment_params)
      @photo = @comment.photo #コメントに紐づいているphotoテーブルを呼び出し
      # binding.pry

  # クライアント要求に応じてフォーマットを変更
     respond_to do |format|
        if @comment.save
          format.html { redirect_to photos_path(@comment), notice: 'コメントを投稿しました。' }
          # JS形式でindexアクションを返す
          format.js {render :index}
        else
          format.html { render :new }
        end

      end

    end

    def edit
      #binding.pry
      redirect_to photos_path(@comment)
    end


    def destroy
      #binding.pry
      @photo =  @comment.photo
      # @comment.destroy
      #クライアントの要求に応じてフォーマットを変更する(respond_toメソッドを使用)
      respond_to do |format|
        if @comment.destroy
          format.html {redirect_to photo_path(@photo)}
          # JS形式でスクリプトを返す=>JS形式のViewファイルが利用できる
          format.js {render :index}
        else
          format.html {render :new}
        end
      end
    end

private
  # ストロングパラメーター
  def comment_params
    params.require(:comment).permit(:photo_id, :content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

end
