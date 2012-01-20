class Course
  include Mongoid::Document
  include Mongoid::Timestamps
  has_and_belongs_to_many :users
  has_many :exams
  belongs_to :category

  field :name, type: String
  validates_presence_of :name
end