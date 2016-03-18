class PostsController < ApplicationController
	before_action :logged_in_user, only: [:edit, :update, :create]

	def index
		# @posts = Post.all.order('created_at DESC')
		@posts  = Post.paginate(:page => params[:page], :per_page => 4).order('created_at DESC')
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@post.tag_list.add(post_params[:tag_list], parse: true)
		if  @post.save

			redirect_to @post
		else
			render 'new'
		end
	end

	def show
		@post = Post.find(params[:id])
	end

	def edit
		@post = Post.find(params[:id])
		
	end

	def update
		@post = Post.find(params[:id])
		if @post.update(params[:post].permit(:title, :body, :tag_list))
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy

		redirect_to posts_path
	end

	def tag_cloud
    	@tags = Post.tag_counts_on(:tags)
  	end

  	def tag
  		@posts = Post.tagged_with(params[:id]).by_join_date.paginate(:page => params[:page], :per_page => 4)
  	end



	private

	

	def post_params
		params.require(:post).permit(:title, :body, :tag_list)
	end

	# 确保用户已登录
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end  
    end
end
