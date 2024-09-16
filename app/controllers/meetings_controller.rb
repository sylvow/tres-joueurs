class MeetingsController < ApplicationController

  before_action :set_params, only: %i[show edit update]
  skip_before_action :authenticate_user!

  def index
    @meetings = Meeting.where.not(status: :cancelled).where.not(status: :finished).where.not(user_id: current_user)

    if params[:search].present?
      params[:search].split(' ').each do |term|
        @meetings = @meetings.joins(:game).where(
          "title ILIKE :term OR games.name ILIKE :term OR games.category ILIKE :term OR location_type ILIKE :term OR place_name ILIKE :term OR place_address ILIKE :term OR lower(tags::text) LIKE lower(:term)",
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
    @meeting.status = Meeting.statuses[:available]
    unless Game.all.pluck(:name).include?(params[:meeting][:game_id])
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

  def history
    @finished_meetings = Meeting.where(status: Meeting.statuses[:finished])
    @other_requests = Request.where(meeting_id: @meetings)
  end

  private

  def set_params
    @meeting = Meeting.find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(:title, :description, :players_needed_min, :players_needed_max, :location_type,
                                    :place_name, :place_address, :latitude, :longitude, :status, :level, :date,
                                    :game_id, :tags)
  end

end
