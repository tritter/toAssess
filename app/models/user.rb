class User
  include Mongoid::Document
  include Mongoid::Timestamps
  has_and_belongs_to_many :courses, :order => [:name, :asc]
  has_many :exams
  has_many :questions
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  field :name, type: String
  validates_presence_of :name

  def admin?
    self.name == 'Administrator'
  end
end
