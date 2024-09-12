class MeetingsController < ApplicationController

  before_action :set_params, only: %i[show edit update]
  skip_before_action :authenticate_user!

  def index
    @meetings = Meeting.all

    if params[:search].present?
      params[:search].split(' ').each do |term|
        @meetings = @meetings.joins(:game)
        @meetings = @meetings.where(
          "games.name ILIKE :term OR games.category ILIKE :term OR location_type ILIKE :term OR place_name ILIKE :term OR place_address ILIKE :term",
          term: "%#{term}%"
        )
      end
    end

    @request = Request.new
    @markers = @meetings.geocoded.map do |m|
      {
        lat: m.latitude,
        lng: m.longitude
      }
    end
  end

  def my_meetings
    @my_meetings = current_user.meetings
  end

  def show
    @request = Request.new
    @meeting = Meeting.find(params[:id])
    @user = current_user
    @request = Request.new
  end

  def new
    @games = Game.all
    @meeting = Meeting.new
  end

  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.players_needed_max = @meeting.players_needed_min if @meeting.players_needed_max.blank?
    @meeting.user = current_user
    if params[:meeting][:game_id].instance_of?(String)
      game = Game.create(name: params[:meeting][:game_id])
      @meeting.game_id = game.id
    end
    if @meeting.save!
      redirect_to meeting_path(@meeting)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def conversations
    @planner_conversations = Meeting.where(user: current_user)
    @participant_conversations = Meeting.joins(:requests).where(requests: { user_id: current_user })
  end

  def messages
    @message = Message.new
    @meeting = Meeting.find(params[:id])
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
