class User < ApplicationRecord
  attr_accessor :remember_token
  #Les paramètres de validation d'un nom
  validates :name, presence: true, length: { maximum: 20 }

#Les paramètres de validation d'un email (taille,caracrère interdit)
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
   validates :email, presence: true, length: { maximum: 250 },
                     format: { with: VALID_EMAIL_REGEX },
                     uniqueness: { case_sensitive: false }
#Obligation de demander un mot de passe lors de la création d'un user
has_secure_password
validates :password, presence: true, length: { minimum: 6 }

class << self
   # Returns the hash digest of the given string.
   def digest(string)
     cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                   BCrypt::Engine.cost
     BCrypt::Password.create(string, cost: cost)
   end

   # Returns a random token.
   def new_token
     SecureRandom.urlsafe_base64
   end
 end

def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
     BCrypt::Password.new(remember_digest).is_password?(remember_token)
   end

def forget
    update_attribute(:remember_digest, nil)
  end

end
