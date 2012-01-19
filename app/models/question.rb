class Question
  include Mongoid::Document
  include Mongoid::Timestamps
  has_and_belongs_to_many :exams
  has_and_belongs_to_many :tags, :autosave => true, :order => [:name, :asc]
  belongs_to :user

  accepts_nested_attributes_for :tags, :reject_if => lambda { |attributes| attributes[:name].blank? }, :allow_destroy => true

  field :type, type: String
  field :question, type: String
  field :answer, type: String
  field :answers, type: Array
  field :texts, type: Array
  field :statements, type: Array
  field :difficulty, type: Integer, default: 5
  field :time, type: Integer, default: 5

  validates_presence_of :type, :question
end
