class User < ApplicationRecord
	attr_accessor :remember_token
	has_many :microposts,dependent: :destroy
	
	validates :name,presence: true, length: {maximum: 50}
	validates :email,presence: true, length: {maximum: 255},uniqueness: true
	has_secure_password
	validates :password,presence: true,length: {minimum: 6},allow_nil: true
	
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST:
								BCrypt::Engine.cost
		BCrypt::Password.create(string,cost:cost)
	end
	
	def User.new_token
		SecureRandom.urlsafe_base64
	end
	
	def remember 
		self.remember_token = User.new_token
		self.update_attribute(:remember_digest,User.digest(remember_token))
	end
	
	def authenticated?(remember_token)
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end
		
	def forget
		update_attribute(:remember_digest,nil)
	end
	
	def feed
		microposts
	end
end
