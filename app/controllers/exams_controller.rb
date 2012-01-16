class ExamsController < ApplicationController
  respond_to :html, :json
  
  def index
    if params[:filters]
      @exams = Exam.scoped
      @exams = @exams.where(:title => /#{params[:search]}/) unless params[:search].blank?
      @exams = @exams.any_in(course_id: params[:course_ids]) unless params[:course_ids].nil?
      @exams = @exams.where(:number_of_questions.lte => params[:number_of_questions]) unless params[:number_of_questions].blank?
      @exams = @exams.where(:average_difficulty.lte => params[:average_difficulty]) unless params[:average_difficulty].blank?
      @exams = @exams.where(:amount_of_time.lte => params[:amount_of_time]) unless params[:amount_of_time].blank?
      @exams = @exams.order_by [:name, :asc]
    else
      @exams = Exam.order_by [:name, :asc]
      @categories = Category.order_by [:name, :asc]
    end
    respond_with @exams
  end

  def show
  end

  def new
    @exam = Exam.new
    @categories = Category.order_by [:name, :asc]
  end

  def create
    @exam = Exam.new params[:exam]
    if @exam.save
      flash[:notice] = 'Tentamen is toegevoegd.'
    end
    redirect_to exams_path
  end

  def edit
    @exam = Exam.find params[:id]
    @categories = Category.order_by [:name, :asc]
  end

  def update
    @exam = Exam.find params[:id]
    if @exam.update_attributes params[:exam]
      flash[:notice] = 'Tentamen is bijgewerkt.'
    end
    redirect_to edit_exam_path @exam
  end

  def destroy
    @exam = Exam.find params[:id]
    if @exam.destroy
      flash[:notice] = 'Tentamen is verwijderd.'
    end
    redirect_to exams_path
  end
end
