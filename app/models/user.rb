class User < ActiveRecord::Base
	#attr_accessible :username, :password, :password_confirmation

	attr_accessor :password
	before_save :encrypt_password

	validates_confirmation_of :password, :on => :create, :message => "should match confirmation"
	validates_presence_of :password, :on => :create
	validates_presence_of :username,  :on => :create, :message => "can't be blank"
	validates_presence_of :email,  :on => :create, :message => "Can't be blank"
	validates_uniqueness_of :username, :email, :on => :create, :message => "must be unique"

	def self.authenticate(email, password)
		user = find_by_email(email)
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_sort)
			user
		else
			nil
		end
	end

	def encrypt_password
		if password.present?
			self.password_sort = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_sort)
		end
	end
end
