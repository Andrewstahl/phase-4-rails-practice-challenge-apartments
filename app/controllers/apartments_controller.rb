class ApartmentsController < ApplicationController
  before_action :set_apartment, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :response_record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :response_unprocessable_entity

  # GET /apartments/
  def index
    @apartments = Apartment.all
    render json: @apartments
  end

  # GET /apartments/1
  def show
    render json: @apartment
  end

  # POST /apartments/
  def create
    @apartment = Apartment.create!(apartment_params)
    render json: @apartment, status: :created
  end

  # PATCH/PUT /apartments/1
  def update
    @apartment.update!(apartment_params)
    render json: @apartment
  end
  
  # DELETE /apartments/1
  def destroy
    @apartment.destroy
    head :no_content
  end
  
  private

  def set_apartment
    @apartment = Apartment.find(params[:id])
  end

  def apartment_params
    params.permit(:number)
  end

  def response_record_not_found
    render json: { error: "Apartment not found" }, status: :not_found
  end

  def response_unprocessable_entity(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

end
