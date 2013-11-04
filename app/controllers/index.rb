enable :sessions 

get '/' do
 @users = User.all 

 # if user's signed in show all 
 # TODO: Show all users if user is signed in
  erb :index 
end

#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page 
  erb :sign_in
end

post '/sessions' do
  user = User.find_by_email(params[:email])
  if user && (params[:password_hash] == user.password_hash) 
    session[:user_id] = user.id
    redirect '/'
  else
    flash[:error] = "Incorrect username or password."
    redirect '/sessions/new'
  end
  # sign-in
end

delete '/sessions/:id' do
  session.clear
  redirect '/'
  # sign-out -- invoked via AJAX
end

#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  erb :sign_up
end

post '/users' do
  new_user = User.create(params[:user])

  if new_user.valid?
    session[:user_id] = new_user.id
    redirect '/'
  else
    flash[:errors] = new_user.errors.full_messages
    redirect '/users/new'
  end
end
