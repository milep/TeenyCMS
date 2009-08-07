get '/' do
  content = Content.first(:region => 'body', :order => [:order.asc])
  if content
    redirect "/page/#{content.id}"
  else
    erb :empty
  end
end
