require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  ## CREATE ##
  get '/posts/new' do   #loads new form
    erb :new
  end

  post '/posts' do   # creates a new post
    @post = Post.create(name: params[:name], content: params[:content])
    redirect to '/posts'
  end

  get '/posts' do #loads index page for all posts
    @posts = Post.all #returns an array of hashes
    erb :index
  end


  ## READ ##
  # grab the post with the id that is in params and set it equal to post
  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :show
  end

  ## UPDATE ##

  get '/posts/:id/edit' do # loads edit form
    @post = Post.find(params[:id])
    erb :edit
  end

  patch '/posts/:id' do #updates a post
    #binding.pry
    @post = Post.find(params[:id])
    @post.name = params[:name]
    @post.content = params[:content]
    @post.save
    redirect to "posts/#{@post.id}"
  end

  ## DELETE ##

  delete '/posts/:id' do
    @post = Post.find(params[:id])
    @post.destroy
    erb :deleted
    # will confirm that this post is deleted
  end

end
