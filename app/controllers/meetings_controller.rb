class MeetingsController < ApplicationController
  
  before_action :set_params, only: %i[show edit update]
  
  def index
    @meetings = Meeting.all
  end

  def my_meetings
    @my_meetings = current_user.meetings
  end

  def show
    @game = Game.find(params[:id])
    @user = current_user
  end

  def new
    @meeting = Meeting.new
  end

  def create
    @meeting = Meeting.new(meeting_params)
    if @meeting.save!
      redirect_to meeting_path(@meeting)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @meeting.update!(meeting_params)
      redirect_to meeting_path(@meeting)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_params
    @meeting = Meeting.find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(:title, :description, :players_needed_min, :players_needed_max, :location_type,
                                    :place_name, :place_address, :latitude, :longitude, :status, :level, :date,
                                    :game_id)
  end

end
