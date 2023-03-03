class LeasesController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_data
  
  def create
    new_lease = Lease.create!(lease_params)
    render json: new_lease, status: :created
  end

  def destroy
    lease = Lease.find(params[:id])
    lease.destroy
  end

  private

  def lease_params
    params.permit(:rent, :apartment_id, :tenant_id)
  end

  def handle_invalid_data(e)
    render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
  end
end
