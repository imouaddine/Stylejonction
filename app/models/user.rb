class User < ActiveRecord::Base

  has_one :portfolio, :dependent => :destroy
  has_many :custom_backgrounds

  after_create :create_default_portfolio

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  attr_accessible :username, :first_name, :last_name, :email, :password, :password_confirmation, :remember_me, :admin


  def full_name
   "#{first_name} #{last_name}"
  end

  def default_project
    in_published = portfolio.published_projects.find_by_default(true)
    in_drafts = portfolio.projects.find_by_default(true)
    return in_published || in_drafts
  end

 
  private

  def create_default_portfolio
    self.portfolio = Portfolio.create(:user => self, :theme => "light")
  end
end
