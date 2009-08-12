class Setting
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :value, Text

  def self.value(name)
    setting = first(:name => name)
    setting ? setting.value : nil
  end
end
