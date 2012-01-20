class QuestionsController < ApplicationController
  authorize_resource
  respond_to :html, :json

  def index
    if params[:filters]
      @questions = Question.scoped
      @questions = @questions.where(question: /#{params[:search]}/) unless params[:search].blank?
      @questions = @questions.any_in(type: params[:types]) unless params[:types].nil?
      @questions = @questions.where(:difficulty.lte => params[:difficulty]) unless params[:difficulty].blank?
      @questions = @questions.where(:time.lte => params[:time]) unless params[:time].blank?
      @questions = @questions.order_by [:created_at, :desc]
    else
      @max_time = Question.order_by([:time, :desc]).limit(1)
    end
    respond_with @questions
  end

  def show
    @question = Question.find params[:id]
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new params[:question]
    if @question.save
      flash[:notice] = 'Vraag is toegevoegd.'
    end
    redirect_to questions_path
  end

  def edit
    @question = Question.find params[:id]
  end

  def update
    @question = Question.find params[:id]
    if @question.update_attributes params[:question]
      flash[:notice] = 'Vraag is bijgewerkt.'
    end
    redirect_to questions_path
  end

  def destroy
    @question = Question.find params[:id]
    if @question.destroy
      flash[:notice] = 'Vraag is verwijderd.'
    end
    redirect_to questions_path
  end
end
