class User < ActiveRecord::Base
	attr_accessor :password


	validates_confirmation_of :password #:on => :create, :message => "should match confirmation"
	validates_presence_of :username,  :on => :create, :message => "Can't be blank"
	validates_presence_of :email,  :on => :create, :message => "Can't be blank"
	validates_uniqueness_of :user, :email, :on => :create, :message => "must be unique"

end
