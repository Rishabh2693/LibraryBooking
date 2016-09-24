class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
  end

  def search
    @rooms = []
    if params.has_key?(:start_time)
      @search_start_time = params[:start_time]
      start_time = DateTime.new(@search_start_time['year'].to_i ,@search_start_time['month'].to_i ,@search_start_time['day'].to_i ,@search_start_time['hour'].to_i ,00,00)
      @search_start_time = DateTime.new(@search_start_time['year'].to_i ,@search_start_time['month'].to_i ,@search_start_time['day'].to_i ,@search_start_time['hour'].to_i ,00,00)
      @search_end_time = params[:end_time]
      end_time = DateTime.new(@search_end_time['year'].to_i ,@search_end_time['month'].to_i ,@search_end_time['day'].to_i ,@search_end_time['hour'].to_i ,00,00)
      @search_end_time = DateTime.new(@search_end_time['year'].to_i ,@search_end_time['month'].to_i ,@search_end_time['day'].to_i ,@search_end_time['hour'].to_i ,00,00)
      @rooms = Room.joins("LEFT OUTER JOIN bookings on rooms.id = bookings.room_id").where("((bookings.start not BETWEEN ? AND ?) AND (bookings.end not BETWEEN ? AND ?)) or bookings.start is null", start_time, end_time, start_time, end_time).distinct
    end
  end

  def bookroom
  end


  def roomhistory
    @history = Booking.where(room_id: params[:id])
  end
  def userhistory
    @history = Booking.where(library_member_id: params[:id])
  end
  # POST /bookings
  # POST /bookings.json
  def create
    tmep = LibraryMember.find_by(email: booking_params[:library_member_id])
    params[:booking][:library_member_id] = tmep.id
    @booking = Booking.new(booking_params)

    respond_to do |format|
      if @booking.save
        format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :search }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:start, :end, :room_id, :library_member_id)
    end
end
