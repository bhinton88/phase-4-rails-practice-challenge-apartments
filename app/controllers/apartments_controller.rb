class ApartmentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_data

  before_action :find_apartment, only: [:show, :update, :destroy]

  def index
    apartments = Apartment.all
    render json: apartments
  end

  def show
    render json: @apartment
  end

  def create
    new_appt = Apartment.create!(apartment_params)
    render json: new_appt, status: :created
  end

  def update
    @apartment.update!(apartment_params)
    render json: @apartment
  end

  def destroy
    @apartment.destroy
    head :no_content
  end

  private

  def find_apartment
    @apartment = Apartment.find(params[:id])
  end

  def apartment_params
    params.permit(:number)
  end

  def record_not_found
    render json: {error: "Apartment not found"}, status: :not_found
  end

  def handle_invalid_data(e)
    render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
  end
end
