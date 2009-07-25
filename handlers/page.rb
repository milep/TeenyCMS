
get %r{/page/([\d]+)$} do |id|
  show_header
  show_menu
  @content = Content.get!(id.to_i)
  if @content.template && template_list.include?(@content.template)
    erb "templates/#{@content.template}".to_sym
  else
    erb :page
  end
end

get '/page/new' do
  show_header
  show_menu
  protected!
  @content = Content.new
  erb :edit_page, {}, {:action => '/page/create', :method => 'post'}
end

get '/page/:id/edit' do
  show_header
  show_menu
  protected!
  @content = Content.get!(params[:id].to_i)
  erb :edit_page, {}, {:action => "/page/#{@content.id}/update", :method => 'put'}
end

put '/page/:id/update' do
  show_header
  show_menu
  protected!
  params[:content][:include_in_menu] = 0 unless params[:content][:include_in_menu]
  @content = Content.get!(params[:id].to_i)
  @content.update_attributes(params[:content])
  erb :edit_page, {}, {:action => "/page/#{@content.id}/update", :method => 'put'}
end

put '/page/:id/up' do
  protected!
  content = Content.get!(params[:id].to_i)
  content.move :up
  redirect '/admin'
end

put '/page/:id/down' do
  protected!
  content = Content.get!(params[:id].to_i)
  content.move :down
  redirect '/admin'
end

post '/page/create' do
  protected!
#  puts "params content: #{params[:content].inspect}"
  content = Content.new(params[:content])
  content.order = Content.next_order_value
  if content.save
#    puts "save succ"
    content.reload
    redirect "/page/#{content.id}/edit"
  else
    puts "FAIL"
  end

end

delete '/page/:id' do
  content = Content.get!(params[:id].to_i)
  content.destroy
  redirect '/admin'
end
