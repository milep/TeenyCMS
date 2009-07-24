class User
#  include DataMapper::Resource
#  property :id, Serial
#  property :login, String
#  property :hashed_password, String
#  property :salt, String
#  property :created_at, DateTime

  attr_accessor :id

  def initialize(id)
    self.id = id
  end

  def self.authenticate(login, password)
    User.new(1) if login == 'admin' && password == 'admin'
  end

  def self.get(id)
    User.new(id)
  end
end
