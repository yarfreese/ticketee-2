class Project < ActiveRecord::Base

  attr_accessible :description, :name

  #? scope :admins, where(:admin => true)

  validates :name, :presence => true, :uniqueness => true

  has_many :tickets, :dependent => :delete_all

  has_many :permissions, :as => :thing
  def self.viewable_by(user)
    joins(:permissions).where(:permissions => { :action => "view",
                              :user_id => user.id })
  end

  def self.for(user)
    user.admin? ? Project : Project.viewable_by(user)
  end

end
