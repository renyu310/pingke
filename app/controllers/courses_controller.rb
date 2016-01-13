class CoursesController < ApplicationController
  def index
    @courses = Course.all
    @all_depart = Course.departCollection
    #@all_type = ["专业核心课", "专业普及课", "专业研讨课", "公共必修课", "公共选修课"].sort
    @all_type = Course.typeCollection
  end

  def show
    @course = Course.find(params[:id])
    @comments = @course.comments
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to @course
    else
      render 'new'
    end
  end

  def destroy
    @courses = Course.all
    @course = Course.find(params[:id])
    respond_to do |format|
      if @course.destroy
        format.html
        format.js
      else
        format.html { render action: "index" }
      end
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])

    if @course.update_attributes(course_params)
      redirect_to @course
    else
      render 'edit'
    end
  end



def search
  keywd = params[:keywd]

  respond_to do |format|
    if keywd
      @courses = Course.where("name LIKE ?", ['%', keywd, '%'].join)
      format.js
    end
  end
end

def filter_courses
  all_depart = Course.departCollection
  all_type = Course.typeCollection

  dfilters = params[:dfilters]
  tfilters = params[:tfilters]

  df = get_filter_params(all_depart, dfilters)
  tf = get_filter_params(all_type, tfilters)

  @courses = Course.where(department: df).where(course_type: tf)

  if @courses
    respond_to do |format|
      format.js
    end
  end

end


private
#健壮参数
def course_params
  params.require(:course).permit(:name, :course_num, :teacher, :department, :introduction, :classroom, :course_type, :credit, :remarks)
end

#:name, :course_num, :teacher, :department, :introduction, :classroom, :commnet_num, :zan, :credit, :type, :remarks

def get_filter_params(all_filiters, filters_index)
  f = Array.new

  if filters_index
    len = filters_index.count
    len.times do |i|
      nn = filters_index[i].to_i-1
      aa = all_filiters[nn]
      f.append(aa)
    end
    return f
  else
    return nil
  end

end

end
