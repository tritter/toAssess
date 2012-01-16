class QuestionsController < ApplicationController
  respond_to :html, :json

  def index
    @questions = Question.all
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
