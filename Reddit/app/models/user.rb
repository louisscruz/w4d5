# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  validates :username, :email, :password_digest, :session_token, presence: true
  validates :username, :password_digest, :session_token, uniqueness: true

  has_many :subs,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Sub
  has_many :posts

  after_initialize :ensure_session_token

  def self.generate_session_token
    begin
      token = SecureRandom::urlsafe_base64
    end while User.exists?(session_token: token)
    token
  end

  def self.find_by_credentials(username,password)
    user = User.find_by(username: username)
    user && user.is_password?(password) ? user : nil
  end

  attr_reader :password

  def is_password?(password)
    bc_object = BCrypt::Password.new(self.password_digest)
    bc_object.is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end
end
