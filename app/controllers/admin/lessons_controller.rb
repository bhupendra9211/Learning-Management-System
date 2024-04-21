class Admin::LessonsController < AdminController
    before_action :set_course
    before_action :set_lesson, only: [:show, :edit]
    def index
        @admin_lessons = @admin_course.lessons.order(:position)
    end

    def new
        @admin_lesson = @admin_course.lessons.new 
    end

    def show
    
    end

    def edit
    
    end

    def create
        @admin_lesson = @admin_course.lessons.new(lesson_params)
    
        if @admin_lesson.save
          redirect_to admin_course_lessons_path(@admin_course)
        else
          render :new
        end
    end

    private
    def set_course
        @admin_course = Course.find(params[:course_id])
    end

    def lesson_params
        params.require(:lesson).permit(:title, :description, :video, :paid, :position)
    end

    def set_lesson
        @admin_lesson = Lesson.find(params[:id])
    end

end
