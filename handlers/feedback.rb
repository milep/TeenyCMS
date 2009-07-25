
post '/modules/feedback' do
  content_type("text/plain")
  feedback = ""
  feedback << "subject: #{params[:feedback][:subject]}\n\n"
  feedback << params[:feedback][:body]
  feedback
end