class PostsController < ApplicationController
  def show
    post = Rails.cache.fetch(params[:id], expires_in: 1.minute) do
      sleep(1)
      post = Post.find(params[:id]).to_json
    end

    render json: post
  end

  def create
    new_post = Post.create(post_params)

    sleep(1)

    render json: { post: new_post }.to_json, status: 201
  end

  private

  def post_params
    params.permit(:title, :body)
  end
end
