require 'bundler/setup'
require 'sinatra'
require "base64"
require "sinatra/cors"

set :allow_origin, "*"
set :allow_methods, "GET,HEAD,POST"
set :allow_headers, "content-type,if-modified-since"
set :expose_headers, "location,link"

get '/' do
  'Hello, world!'
end

get '/form' do
  # Render the form.html file
  erb :form
end

post '/upload' do
	json_body = JSON.parse(request.body.read)
	content = json_body['file'].split(';')[1].split(',')[1]
	# Save the uploaded file to disk
	File.open('uploads/signature.png', "w") do |f|
		f.write(Base64.decode64(content))
		# f.write content
	end
	# Return a success response
	status 200
	body 'File uploaded successfully'
end
