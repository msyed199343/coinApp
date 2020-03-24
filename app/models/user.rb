# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  api_key         :string           not null
#  created_at      :datetime
#  updated_at      :datetime
#  email           :string
#  password_digest :string
#  account_type    :string
#

class User < ApplicationRecord
    validates :api_key, :email, :password_digest, null: false, uniqueness: true
    has_many :transactions
    validates :password, length: {minimum: 7}

    after_initialize :ensure_key
    attr_reader :password 



    def self.find_by_credentials(email, password, key)
    #finds user by api_key and email
        @user = User.find_by(api_key: key, email: email)
        #returns nul if user is not found 
        return nil if @user.nil?
             
        #if user is found and skips above if statement then check if given password is correct if yes return user 
        #or else it will return nil
        
        @user.check_pass(password) ? @user : nil
    end

    def check_pass(password)
        #checks if password given from user matches bcrypt version in database 
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end  

    def password=(password)
        #sets the password with bcrypt
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def reset_api_key!
        #resets key if needed
        self.api_key = self.generate_api_key
    end

    def generate_key
        #generates a random key
        SecureRandom.base64(16)
    end
    
    private
 
    def ensure_key
        #checks if api_key exists else one will be assigned!
        self.api_key ||= self.generate_key
    end

end
