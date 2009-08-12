
get '/admin' do
  show_header
  show_menu
  protected!
  @pages = Content.all(:region => 'body', :include_in_menu => true, :order => [:order.asc])
  erb :admin
end

get '/admin/settings' do
  show_header
  show_menu
  protected!
  @settings = Setting.all.inject({}) do |memo, setting|
    memo[setting.name] = setting.value
    memo
  end
  erb :settings
end

put '/admin/settings' do
  show_header
  show_menu
  protected!
  params[:setting].each_pair do |k, v|
    setting = Setting.first_or_create(:name => k)
    setting.update_attributes(:value => v)
  end
  redirect '/admin/settings'
end