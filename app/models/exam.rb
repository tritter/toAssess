class Exam
  include Mongoid::Document
  include Mongoid::Timestamps
  has_and_belongs_to_many :questions, :autosave => true
  belongs_to :course
  belongs_to :user

  accepts_nested_attributes_for :questions, :reject_if => lambda { |attributes| attributes[:question].blank? || attributes[:type].blank? }, :allow_destroy => true

  field :category_name, type: String
  field :course_name, type: String
  field :author, type: String
  field :title, type: String
  field :description, type: String
  field :number_of_questions, type: Integer
  field :average_difficulty, type: Float
  field :amount_of_time, type: Integer

  validates_presence_of :title, :description

  before_save :handle_summary_fields

  private
  @callback = false
  def handle_summary_fields()
    if not @callback
      self.category_name = course.category.name
      self.course_name = course.name
      self.author = user.name
      if self.questions.length > 0
        self.number_of_questions = questions.length
        self.average_difficulty = questions.collect { |q| q.difficulty.to_f }.inject(:+) / questions.length
        self.amount_of_time = questions.collect { |q| q.time.to_i }.inject(:+)
      else
        self.number_of_questions = 0
        self.average_difficulty = 0
        self.amount_of_time = 0
      end
      @callback = true
      self.save
    end
  end
end
