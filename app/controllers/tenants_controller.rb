class TenantsController < ApplicationController
  before_action :set_tenant, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :response_record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :response_unprocessable_entity

  def index
    @tenants = Tenant.all
    render json: @tenants
  end

  def show
    render json: @tenant
  end

  def create
    @tenant = Tenant.create!(tenant_params)
    render json: @tenant, status: :created
  end

  def update
    @tenant.update!(tenant_params)
    render json: @tenant
  end

  def destroy
    @tenant.destroy!
    head :no_content
  end

  private
  
  def set_tenant
    @tenant = Tenant.find(params[:id])    
  end 

  def tenant_params
    params.permit(:name, :age)
  end

  def response_record_not_found
    render json: { error: "Tenant not found" }, status: :not_found
  end

  def response_unprocessable_entity(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

end
