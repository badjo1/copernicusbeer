class User < ApplicationRecord
  attr_accessor :remember_token, :nonce_token
  has_many :animated_gifs

  validates :eth_address, presence: true, length: { maximum: 255 },
                    if: -> { Eth::Address.new(eth_address).valid? },
                    uniqueness: { case_sensitive: false }
  # validate :valid_eth_adress

  def valid_eth_adress
    address = Eth::Address.new(self.eth_address)
    address.valid?
  end                    
   
  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

   # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Sets the nonce attributes.
  def create_nonce_digest
    self.nonce_token = User.new_token
    update_attribute(:nonce_digest,  User.digest(nonce_token))
    #todo change in nonce_sent_at
    update_attribute(:nonce_at, Time.zone.now) 
  end

  # Returns true if a password reset has expired.
  def nonce_reset_expired?
    nonce_at < 5.minutes.ago
  end

  def masked_eth_address  
    first_seven = self.eth_address[0, 7] # include '0x' over voor selectie
    last_five = self.eth_address[-5, 5]
    "#{first_seven}...#{last_five}"
  end

end
