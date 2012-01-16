class Question
  include Mongoid::Document
  include Mongoid::Timestamps
  has_and_belongs_to_many :exams
  has_and_belongs_to_many :tags, :autosave => true, :order => [:name, :asc]
  belongs_to :user

  accepts_nested_attributes_for :tags, :reject_if => lambda { |attributes| attributes[:name].blank? }, :allow_destroy => true

  field :question_type, type: String
  field :question, type: String

  validates_presence_of :question_type, :question

  private
  def check_question_type
    errors.add(:question_type, 'invalid question') unless %W[open mc thesis].include? self.question_type
  end
end
