require 'dm-core'
require 'lib/models/user'
require 'lib/models/content'
require 'handlers/session'
require 'handlers/root'
require 'handlers/admin'
require 'handlers/files'
require 'handlers/page'
require 'lib/login_management'

configure :development do
  #  p 'conf dev'
  begin
    DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/db/teenycms.sqlite3")
    DataMapper.auto_upgrade!
  rescue Exception => e
    p "error: #{e.inspect}"
  end
end

#configure :production do
#  DataMapper.setup(:default, 'teenycms.sqlite3')
#end


helpers do
  def protected!
    throw(:warden) and \
      return unless env['warden'].authenticated?(:password)
  end

  def show_header
    header = Content.first(:region => 'header')
    @header_content = (header && header.body) || "create new header, please"
  end

  def show_menu
    @menu_items = Content.all(:region => 'body', :include_in_menu => true, :order => [:order.asc]).map do |content|
      {:id => content.id, :title => content.title}
    end
  end
end

get '/javascript/lists/link_list.js' do
  content_type("text/javascript")
  @links = []
  Content.all(:region => 'body').each do |content|
    @links << "[\"#{content.title}\", \"../page/#{content.id}\"]"
  end
  erb :"javascripts/link_list", :layout => false
end
