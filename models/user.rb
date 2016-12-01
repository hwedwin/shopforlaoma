class User
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  embeds_many :roles
  has_one :balance
  has_one :user_node
  has_many :orders

  # field <name>, :type => <type>, :default => <value>
  field :username, :type => String
  field :crypted_pass, :type => String
  field :email, :type => String
  field :mobile, :type => String
  field :email,            :type => String
  field :crypted_password, :type => String
  field :is_seller, :type => Boolean

  attr_accessor :password, :password_confirmation


  # Validations

  validates_presence_of     :username
  validates_presence_of     :password,                   :if => :password_required
  validates_presence_of     :password_confirmation,      :if => :password_required
  validates_length_of       :password, :within => 4..40, :if => :password_required
  validates_confirmation_of :password,                   :if => :password_required

  # Callbacks
  before_save :encrypt_password, :if => :password_required

  ##
  # This method is for authentication purpose.
  #
  def self.authenticate(username, password)
    user = where(:username => /#{Regexp.escape(username)}/i).first if username.present?
    user && user.has_password?(password) ? user : nil
  end

  ##
  # This method is used by AuthenticationHelper.
  #
  def self.find_by_id(id)
    find(id) rescue nil
  end

  def has_password?(password)
    ::BCrypt::Password.new(crypted_password) == password
  end

  private

  def encrypt_password
    self.crypted_password = ::BCrypt::Password.create(self.password)
  end

  def password_required
    crypted_password.blank? || self.password.present?
  end
end
