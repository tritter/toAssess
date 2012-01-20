class ExamsController < ApplicationController
  authorize_resource
  respond_to :html, :json, :pdf
  
  def index
    if params[:filters]
      @exams = Exam.scoped
      @exams = @exams.any_of({ title: /#{params[:search]}/ }, { description: /#{params[:search]}/ }) unless params[:search].blank?
      @exams = @exams.any_in(course_id: params[:course_ids]) unless params[:course_ids].nil?
      @exams = @exams.where(:number_of_questions.lte => params[:number_of_questions]) unless params[:number_of_questions].blank?
      @exams = @exams.where(:average_difficulty.lte => params[:average_difficulty]) unless params[:average_difficulty].blank?
      @exams = @exams.where(:amount_of_time.lte => params[:amount_of_time]) unless params[:amount_of_time].blank?
      @exams = @exams.order_by [:created_at, :desc]
    else
      @max_number_of_questions = Exam.order_by([:number_of_questions, :desc]).limit(1)
      @max_amount_of_time = Exam.order_by([:amount_of_time, :desc]).limit(1)
      @categories = Category.order_by [:name, :asc]
    end
    respond_with @exams
  end

  def show
    @exam = Exam.find params[:id]
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf                            => "#{@exam.category_name}-#{@exam.course_name}_#{@exam.title}_#{@exam.updated_at.to_s.slice 0, 10}_#{@exam.author}",
               :template                       => 'exams/show.pdf.erb',
               :layout                         => 'pdf.html',                   # use 'pdf.html' for a pdf.html.erb file
               :wkhtmltopdf                    => '/usr/bin/wkhtmltopdf',       # path to binary
               :show_as_html                   => params[:debug].present?      # allow debuging based on url param
      end
    end
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
    redirect_to exams_path
  end

  def destroy
    @exam = Exam.find params[:id]
    if @exam.destroy
      flash[:notice] = 'Tentamen is verwijderd.'
    end
    redirect_to exams_path
  end
end
