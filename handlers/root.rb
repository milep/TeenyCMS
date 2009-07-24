get '/' do
  content = Content.first(:region => 'body', :order => [:order.asc])
  if content
#    erb :page
    redirect "/page/#{content.id}"
  else
    erb :empty
  end
end
