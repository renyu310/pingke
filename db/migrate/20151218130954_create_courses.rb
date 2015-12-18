class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :course_num    #课程编号
      t.string :teacher
      t.string :department    #开课学院
      t.string :introduction  #介绍
      t.string :classroom     #上课教室
      t.string :commnet_num   #评论数
      t.string :zan           #赞数
      t.string :credit        #学分
      t.string :type          #课程类型 比如公共课
      t.string :remarks       #备注字段


      t.timestamps null: false
    end
  end
end
