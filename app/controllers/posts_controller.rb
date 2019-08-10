class PostsController < ApplicationController
  def show
    post = Post.find(params[:id])

    sleep(1)

    render json: { title: post.title, body: post.body }.to_json
  end

  def create
    new_post = Post.create(post_params)
    render json: { post: new_post }.to_json, status: 201
  end

  private

  def post_params
    params.permit(:title, :body)
  end
end
