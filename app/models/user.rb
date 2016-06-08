#Model for User that communicates with the User Table

class User < ActiveRecord::Base
	#Indicate that a user can be author of many articles
	has_many :articles 
	before_save { self.email = email.downcase }

	#Validating User Information Before saving it 
	validates :username, presence: true, uniqueness: {case_sensitive: false} , length: { minimum: 3, maximum: 25 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 105 },
		uniqueness: {case_sensitive: false},
		format: { with: VALID_EMAIL_REGEX }

	#Use the has_secure_password method in a User
	has_secure_password
end
