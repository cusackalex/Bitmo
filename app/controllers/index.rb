get '/' do
  if logged_in?
    redirect "/profile/#{current_user.username}"
  else
    erb :index
  end
end


get '/profile/:username' do
  redirect '/' if current_user == nil
  if current_user.username == params[:username]
    @user = current_user
    get_all_user_transactions
    get_pending_transaction
    chronological_sort_transactions
    erb :profile
  else
    @user = User.where(username: params[:username]).first
    view_profile_transactions
    erb :profile
  end
end


get '/listener' do
 return params[:venmo_challenge]
end



get '/search' do
  user = User.where(email: params[:query]).first
  user = Friend.where(email: params[:query]).first if user.nil?
  if user
    redirect "/profile/#{user.username}"
  else
    @errors = "We didn't find anyone with that username"
    redirect "profile/#{current_user.username}"
  end
end