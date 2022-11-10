class LeasesController < ApplicationController
  before_action :set_lease, only: [:destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :response_record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :response_unprocessable_entity

  # POST /leases/
  def create
    @lease = Lease.create!(lease_params)
    render json: @lease, status: :created
  end

  # DELETE /leases/1
  def destroy
    @lease.destroy
    head :no_content
  end
  
  private

  def set_lease
    @lease = Lease.find(params[:id])
  end

  def lease_params
    params.permit(:rent, :apartment_id, :tenant_id)
  end

  def response_record_not_found
    render json: { error: "Lease not found" }, status: :not_found
  end

  def response_unprocessable_entity(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

end
