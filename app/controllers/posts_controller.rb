class PostsController < ApplicationController
  def show
    post = Post.find(params[:id])

    render json: { title: post.title, body: post.body }.to_json
  end

  def create
    require 'pry'; binding.pry
    new_post = Post.create(post_params)
    render json: { post: new_post }.to_json
  end

  private

  def post_params
    params.permit(:title, :body)
  end
end
