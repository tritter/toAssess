class Question
  include Mongoid::Document
  include Mongoid::Timestamps
  has_and_belongs_to_many :exams
  belongs_to :user

  field :type, type: String
  field :question, type: String
  field :answer, type: String
  field :answers, type: Array
  field :texts, type: Array
  field :statements, type: Array
  field :difficulty, type: Integer, default: 5
  field :time, type: Integer, default: 5
  field :author, type: String

  validates_presence_of :type, :question

  before_save :handle_summary_fields

  private
  @callback = false
  def handle_summary_fields()
    if not @callback
      self.author = user.name
      @callback = true
      self.save
    end
  end
end
