class User < ActiveRecord::Base
  devise :database_authenticatable, :token_authenticatable, :registerable,
         :recoverable, :lockable, :rememberable, :confirmable, :validatable


end
