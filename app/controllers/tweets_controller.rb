class TweetsController < ApplicationController
  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if Helpers.is_logged_in?(session)
      if params[:content] == ""
        redirect '/tweets/new'
      else
        @user = Helpers.current_user(session)
        Tweet.create(:content => params[:content], :user_id => @user.id)
        redirect '/tweets'
      end
    end
    redirect '/login'
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content] == ""
      redirect "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find(params[:id])
      @tweet.update(:content => params[:content])
      redirect "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id/edit' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/delete' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      @tweet = Tweet.find(params[:id])

      if @tweet.user == @user
        @tweet.destroy
      end
    end

    redirect '/tweets'
  end
end
