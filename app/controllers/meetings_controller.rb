class MeetingsController < ApplicationController

  before_action :set_params, only: %i[show edit update cancel mark_as_full messages]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @meetings = Meeting.where.not(status: :cancelled).where.not(status: :finished).where.not(user_id: current_user)

    if params[:lat].present? && params[:lng].present? && params[:radius].present?
      @close_meetings = Meeting.near([params[:lat], params[:lng]], params[:radius])
    end

    if params[:search].present?
      params[:search].split(' ').each do |term|
        @meetings = @meetings.joins(:game).where(
          "title ILIKE :term OR games.name ILIKE :term OR games.category ILIKE :term OR location_type ILIKE :term OR place_name ILIKE :term OR place_address ILIKE :term OR lower(tags::text) LIKE lower(:term)",
          term: "%#{term}%"
        )
      end
    end

    @meetings = @close_meetings & @meetings unless @close_meetings.blank?
    @request = Request.new

    # @start_date = Date.today
    # @end_date = @start_date + 29.days
    # @dates = (@start_date..@end_date).to_a

    # @selected_date = params[:date] ? Date.parse(params[:date]) : nil

    # @meetings = if @selected_date
    #               Meeting.where(date: @selected_date.beginning_of_day..@selected_date.end_of_day)
    #             else
    #               Meeting.where.not(status: :cancelled).where.not(status: :finished).where.not(user_id: current_user)
    #             end

    # if params[:search].present?
    #   params[:search].split(' ').each do |term|
    #     @meetings = @meetings.joins(:game).where(
    #       "title ILIKE :term OR games.name ILIKE :term OR games.category ILIKE :term OR location_type ILIKE :term OR place_name ILIKE :term OR place_address ILIKE :term OR lower(tags::text) LIKE lower(:term)",
    #       term: "%#{term}%"
    #     )
    #   end

    # @markers = @meetings.geocoded.map do |m|
    #   {
    #     lat: m.latitude,
    #     lng: m.longitude
    #   }
    # end
  end

  def my_meetings
    @my_meetings = current_user.meetings
  end

  def show
    @request = Request.new
    @user = current_user
    if @user
      @user_request = Request.find_by(meeting_id: @meeting.id, user_id: @user.id)
    else
      @user_request = nil
    end
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

  def mark_as_full
    if @meeting.full?
      @meeting.available!
      redirect_to requests_path if @meeting.save!
    elsif @meeting.available?
      @meeting.full!
      redirect_to requests_path if @meeting.save!
    else
      render :requests_path, status: :unprocessable_entity
    end
  end

  def history
    @finished_meetings = Meeting.where(status: Meeting.statuses[:finished])
    @other_requests = Request.where(meeting_id: @meetings)
  end

  def cancel
    if @meeting.user == current_user
      if @meeting.cancelled!
        render json: { 
          message: "Votre rencontre à été supprimé.",
          title: @meeting.localized_status,
          redirect_url: requests_path
          }, status: :ok
      else
        render json: {
          message: "Quelque chose s'est mal passé 😥",
          title: "Oups.." 
          }, status: :unprocessable_entity
      end
    else
      render json: {
        message: "Vous n'êtes pas autorisé à annuler cette rencontre.",
        title: "Accès refusé"
      }, status: :forbidden
    end
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
