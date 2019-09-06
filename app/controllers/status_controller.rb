class StatusController < ApplicationController
  def status
    render json: { status: :ok }.to_json, status: 200
  end
end