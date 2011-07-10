class User < ActiveRecord::Base

  has_one :portfolio, :dependent => :destroy
  has_many :custom_backgrounds

  after_create :create_default_portfolio

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  attr_accessible :username, :first_name, :last_name, :email, :password, :password_confirmation, :remember_me


  def full_name
   "#{first_name} #{last_name}"
  end

  def default_project
    portfolio.projects.default.first
  end

  private

  def create_default_portfolio
    self.portfolio = Portfolio.new(:user => self, :theme => "light")
    self.portfolio.save!
  end
end
