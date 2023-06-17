class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  acts_as_token_authenticatable

  validates :name, presence: true, length: { minimum: 3, maximum: 30 }
  validates :email, presence: true, uniqueness: true
  validates :is_admin, inclusion: [true, false], exclusion: [nil]
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
