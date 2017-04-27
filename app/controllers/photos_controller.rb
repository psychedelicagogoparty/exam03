class PhotosController < ApplicationController
  #ログインしていなければ投稿機能を使用できないようにする(Deviseのauthenticate_user!メソッドを使用)
  before_action :authenticate_user!

  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  # before_action :check_user

  # GET /photos
  def index
    @photos = Photo.all
    
  end


  # GET /photos/new
  def new

    if params[:back]
      @photo =  Photo.new(photo_params)
    else
      @photo = Photo.new
    end

  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)

    @photo.user_id = current_user.id #user_idカラムにユーザーidを格納

      #photoテーブルの書き込み時の処理
      if @photo.save
        redirect_to photos_url, notice: '写真が投稿されました'
        # render :show, status: :created, location: @photo
      else
        render :new
      end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to photos_url, notice: '写真が更新されました！.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: '写真の削除が完了しました' }
    end
  end

  private

    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:name, :content, :user_id, :photo)
    end

end
