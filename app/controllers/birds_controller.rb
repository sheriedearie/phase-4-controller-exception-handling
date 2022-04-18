class BirdsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  # that way if any of the controller actions throw an exception the method will return the appropriate JSON resp

  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  def create
    bird = Bird.create(bird_params)
    render json: bird, status: :created
  end

  # GET /birds/:id
  def show
    bird = find_bird
    render json: bird
  end

  # PATCH /birds/:id
  def update
    bird = find_bird
    bird.update(bird_params)
    render json: bird
  end

  # PATCH /birds/:id/like
  def increment_likes
    bird = find_bird
    bird.updates(likes: bird.likes + 1)
    render json:bird
  end

  # DELETE /birds/:id
  def destroy
    bird = find_bird
    bird.destroy
    head :no_content
  end

  private

  # helper method to find a bird based on the ID in the params hash
  def find_bird
    Bird.find(params[:id])
  end
  
  def bird_params
    params.permit(:name, :species, :likes)
  end

  # private method for generating the not found response
  def render_not_found_response
    render json: { error: "Bird not found" }, status: :not_found
  end
end