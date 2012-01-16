class Category
  include Mongoid::Document
  include Mongoid::Timestamps
  has_many :courses, :autosave => true, :order => [:name, :asc]

  accepts_nested_attributes_for :courses, :reject_if => lambda { |attributes| attributes[:name].blank? }, :allow_destroy => true

  field :name, type: String
  validates_presence_of :name
end
