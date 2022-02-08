class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, :uniqueness => { :case_sensitive => false } 
  validates :password, confirmation: true, presence: true, length: { in: 6..20 }

  def self.authenticate_with_credentials (email, password) 
    #active record provides this .find_by_email method by default
    #you can use either way but one will return nil if it can't find, and one will throw and error and end the code there (find_by id: vs. find_by_id LOOK INTO IT here
    #user = self.find_by email:
    email.strip!
    email.downcase!
    user = self.find_by_email(email) 
    if user && user.authenticate(password)
      return user #you can remove return but it's easier to read and understand
    else 
      return nil
    end 

  end 

  def self.find_by_email email
    #User.where('email = ?', email) without .first it will return [result]
    User.where('email = ?', email).first #returns result NOT NESTED IN ARRAY that way when you call .authenticate it's on the user and no the user nested in array
    
  end


end




# t.string   "email"
# t.string   "password_digest"
# t.datetime "created_at",      null: false
# t.datetime "updated_at",      null: false
# t.string   "first_name"
# t.string   "last_name"