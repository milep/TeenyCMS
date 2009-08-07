get '/admin/upload' do
  show_header
  show_menu
  protected!
  erb :upload
end

post '/admin/upload' do
  show_header
  show_menu
  protected!
  tempfile = params[:file][:tempfile]
  @filename = "/user_data/#{params[:file][:filename]}"
  FileUtils.copy(tempfile.path, "#{Dir.pwd}/public#{@filename}")
  FileUtils.chmod(0644, "#{Dir.pwd}/public#{@filename}")
  erb :upload
end

get '/javascript/lists/image_list.js' do
  content_type("text/javascript")
  dir = Dir.new(Dir.pwd + "/public/user_data")
  @files = []
  dir.each do |filename|
    if filename =~ /png$|jpg$|jpeg$|gif$/
      @files << "[\"#{filename}\", \"/user_data/#{filename}\"]" if File.file?(Dir.pwd + "/public/user_data/" + filename)
    end
  end
  erb :"javascripts/image_list", :layout => false
end
