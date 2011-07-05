class User < ActiveRecord::Base
  
  has_one :portfolio
  has_many :custom_backgrounds  

  after_create :create_default_portfolio 

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  attr_accessible :username, :first_name, :last_name, :email, :password, :password_confirmation, :remember_me
  
  
  def full_name
   "#{first_name} #{last_name}"
  end


  private 

  def create_default_portfolio
    self.portfolio = Portfolio.new(:user => self)
    self.portfolio.save
  end
end
