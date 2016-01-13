class Course < ActiveRecord::Base
  has_and_belongs_to_many :users

  has_many :comments

  def Course.departCollection
    departcollect = Array.new
    i=0
    Course.select(:department).distinct.each do |course|
      departcollect[i] = course.department
      i+=1
    end
    return departcollect.sort
  end

  def Course.typeCollection
    typecollect = Array.new
    i=0
    Course.select(:course_type).distinct.each do |course|
      typecollect[i] = course.course_type
      i+=1
    end
    return typecollect.sort
  end

end

