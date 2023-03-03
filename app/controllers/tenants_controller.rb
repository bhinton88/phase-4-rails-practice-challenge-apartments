class TenantsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_data

  before_action :find_tenant, only: [:show, :update, :destroy]

  def index
    tenants = Tenant.all
    render json: tenants
  end
  
  def show
    render json: @tenant
  end

  def create
    new_tenant = Tenant.create!(tenant_params)
    render json: new_tenant, status: :created
  end

  def update
    @tenant.update!(tenant_params)
    render json: @tenant
  end

  def destroy
    @tenant.destroy
    head :no_content
  end

  private

  def find_tenant
    @tenant = Tenant.find(params[:id])
  end

  def tenant_params
    params.permit(:name, :age)
  end

  def record_not_found
    render json: {error: "Tenant not found"}, status: :not_found
  end

  def handle_invalid_data(e)
    render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
  end

end
