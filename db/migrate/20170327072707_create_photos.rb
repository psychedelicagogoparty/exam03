class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :name　#ユーザー名
      t.text :content #投稿内容
      t.integer :user_id #id

      t.timestamps null: false
    end
  end
end
