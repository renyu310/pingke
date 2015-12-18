class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content         #内容
      t.integer :user_id      #用户id
      t.integer :course_id    #课程id
      t.integer :parent_id    #嵌套评论id

      t.timestamps null: false
    end
    add_index :comments, :user_id
    add_index :comments, :course_id
    add_index :comments, :parent_id
  end
end
