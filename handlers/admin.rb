
get '/admin' do
  show_header
  show_menu
  protected!
  @pages = Content.all(:region => 'body', :include_in_menu => true, :order => [:order.asc])
  erb :admin
end