get '/admin/upload' do
  show_header
  show_menu
  protected!
  #@filename = ""
  erb :upload
end

post '/admin/upload' do
  show_header
  show_menu
  protected!
  tempfile = params[:file][:tempfile]
  @filename = "/images/#{params[:file][:filename]}"
  FileUtils.copy(tempfile.path, "#{Dir.pwd}/public#{@filename}")
  FileUtils.chmod(0644, "#{Dir.pwd}/public#{@filename}")
  erb :upload
end

get '/javascript/lists/image_list.js' do
  content_type("text/javascript")
  dir = Dir.new(Dir.pwd + "/public/images")
  @files = []
  dir.each do |filename|
    @files << "[\"#{filename}\", \"/images/#{filename}\"]" if File.file?(Dir.pwd + "/public/images/" + filename)
  end
  erb :"javascripts/image_list", :layout => false
end
