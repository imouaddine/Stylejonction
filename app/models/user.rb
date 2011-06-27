class User < ActiveRecord::Base
  
  has_one :portfolio
  
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable, :confirmable


  

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :first_name, :last_name, :email, :password, :password_confirmation, :remember_me
  
  
  def full_name
   first_name + " " + last_name
  end
end
