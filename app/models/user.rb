class User < ActiveRecord::Base

  has_many :portfolios, :dependent => :destroy
  has_many :custom_backgrounds

  after_create :create_default_portfolio

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  attr_accessible :username, :first_name, :last_name, :email, :password, :password_confirmation, :remember_me, :admin


  def full_name
   "#{first_name} #{last_name}"
  end

  def default_project
    portfolio.projects.default.first
  end

  def portfolio
    portfolios.find_by_published(false)
  end

  def published_portfolio
    portfolios.find_by_published(true)
  end

  private

  def create_default_portfolio
    self.portfolios << Portfolio.create(:user => self, :theme => "light")
  end
end
