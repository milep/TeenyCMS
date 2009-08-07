require 'pony'

post '/modules/feedback' do
  feedback = ""
  begin
    Pony.mail(
      :to => 'maleppanen@gmail.com',
      :from => params[:feedback][:email],
      :subject => params[:feedback][:subject],
      :body => params[:feedback][:body],
      :via => :smtp,
      :smtp => CONFIG[:smtp])
  rescue Exception => e
    feedback << "failed: #{e.message}\n\n"
  end
  feedback << "subject: #{params[:feedback][:subject]}\n\n"
  feedback << "from: #{params[:feedback][:email]}\n\n"
  feedback << params[:feedback][:body]

  content_type("text/plain")
  feedback
end