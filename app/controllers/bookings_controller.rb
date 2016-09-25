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
      @duration = params[:duration]
      @size = params[:size]
      @building = params[:building]
      @search_start_time = DateTime.new(params[:start_time]['year'].to_i ,params[:start_time]['month'].to_i ,params[:start_time]['day'].to_i ,params[:start_time]['hour'].to_i ,00,00)
      @search_end_time = @search_start_time + @duration.to_i().hours
      subquery = Room.joins("LEFT OUTER JOIN bookings on rooms.id = bookings.room_id").where("((? >= bookings.start AND ? < bookings.end ) OR ( ? > bookings.start AND ? <= bookings.end ))", @search_start_time, @search_start_time, @search_end_time, @search_end_time).distinct.select('rooms.room_number')
      if @size != 'Any' and @building != 'Any'
        @rooms = Room.where(" room_number not in (?)", subquery).where(" size = ?", @size).where(" building = ?", @building)
      elsif @size != 'Any'
        @rooms = Room.where(" room_number not in (?)", subquery).where(" size = ?", @size)
      elsif @building != 'Any'
        @rooms = Room.where(" room_number not in (?)", subquery).where(" building = ?", @building)
      else
        @rooms = Room.where(" room_number not in (?)", subquery)
      end
    end
  end

  def bookroom
  end


  def roomhistory
    @history = Booking.where(room_id: params[:id]).order(:start)
  end
  def userhistory
    @history = Booking.where(library_member_id: params[:id]).order(:start)
  end
  # POST /bookings
  # POST /bookings.json
  def create
    subquery = Booking.where(library_member_id: params[:booking][:library_member_id]).where("((? >= bookings.start AND ? < bookings.end ) OR ( ? > bookings.start AND ? <= bookings.end ))", DateTime.parse(params[:booking][:start]), DateTime.parse(params[:booking][:start]), DateTime.parse(params[:booking][:end]), DateTime.parse(params[:booking][:end])).first
    @booking = Booking.new(booking_params)
    if subquery and !current_user.admin?
      respond_to do |format|
        @booking.errors.add(:you, " cannot book 2 rooms at the same time")
        format.html { render :search }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    else
      respond_to do |format|
        if @booking.save
          @library_member = LibraryMember.find(params[:booking][:library_member_id])
          format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
          format.json { render :show, status: :created, location: @booking }
        else
          format.html { render :search }
          format.json { render json: @booking.errors, status: :unprocessable_entity }
        end
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
