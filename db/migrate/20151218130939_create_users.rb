class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :age
      t.string :gender        #性别
      t.string :phone         #电话号码
      t.string :department    #学院
      t.string :major         #专业
      t.string :picture       #图片路径
      t.string :tag           #签名
      t.string :qq            #QQ号
      t.string :introduction  #简单介绍

      t.timestamps null: false
    end
  end
end
