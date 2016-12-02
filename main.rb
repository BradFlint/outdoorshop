require 'sinatra'
require 'sendgrid-ruby'
include SendGrid

get '/home' do  ##link to the home page##
	erb :home
end

get '/camping' do  ##link to the camping page##
	erb :camping
end

get '/contact' do  ##link to the contact page##
	erb :form
end

get '/fishing' do  ##link to the fishing page##
	erb :fishing
end

get '/' do
	erb :home
end
## json pulls the user input entered in the name, email and comment fields and sends email to me ##
post '/form' do
	puts params.inspect
	data = JSON.parse('{
	  "personalizations": [
	    {
	      "to": [
	        {
	          "email": "bradwflint@gmail.com"
	        }
	      ],
	      "subject": "'+ params[:username] +'"
	    }
	  ],
	  "from": {
	    "email": "'+ params[:email] +'"
	  },
	  "content": [
	    {
	      "type": "text/plain",
	      "value": "'+ params[:comments] +'"
	    }
	  ]
	}')
	sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
	response = sg.client.mail._("send").post(request_body: data)
	puts response.status_code
	puts response.body
	puts response.headers
	erb :home
end


