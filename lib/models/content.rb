class Content
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :region, String
  property :template, String
  property :include_in_menu, Boolean
  property :order, Integer
  property :body, Text
  property :created_at, DateTime

  def move(direction)
    case direction
    when :up
      change_order(1)
    when :down
      change_order(-1)
    else
      raise "Invalid direction: #{direction}"
    end
  end

  def destroy
    Content.all(:order.gt => self.order, :include_in_menu => true).each do |content|
      content.order -= 1
      content.save
    end
    super
  end

  def self.next_order_value
    repository(:default).adapter.query("SELECT MAX(`order`) FROM contents").first.to_i + 1
  end
  
  private
  def change_order(d)
    prev_content = Content.first("order" => self.order - d)
    if prev_content
      prev_content.order += d
      prev_content.save
    end
    self.order -= d
    self.save
  end
end
