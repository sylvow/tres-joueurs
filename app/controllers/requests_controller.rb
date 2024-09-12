class RequestsController < ApplicationController

  helper_method :compute_players_needed
  before_action :set_request, except: [:index, :create]

  def index
    @user_meetings = Meeting.where(user_id: current_user).where.not(status: :cancelled).where.not(status: :finished) # View Mes jeux en cours ORGA - OK
    @requested_meetings = Meeting.joins(:requests).where(requests: { user_id: current_user }) # View Mes jeux en cours PARTICIPANT - OK

    @finished_meetings = Meeting.where(status: Meeting.statuses[:finished])
    @other_requests = Request.where(meeting_id: @meetings)
  end

  def show
  end

  def create
    @meeting = Meeting.find(params[:meeting_id])
    @request = Request.new(request_params)
    @request.user = current_user
    @request.meeting = @meeting
    @request.status = Request.statuses[:interested]
    if @request.save!
      redirect_to requests_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @request.update!(request_params) && request_params[:status] == Request.statuses[:rejected]
      destroy
    elsif @request.update!(request_params)
      redirect_to requests_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @request.destroy
    redirect_to requests_path, status: :see_other
  end

  def compute_players_needed(meeting)
    requests = Request.where(meeting_id: meeting.id)
    meeting.players_needed_max - requests.sum(:number_of_friends) - requests.count
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end

  def historical_player_meetings
    Meeting.where(user_id: current_user, status: Meeting.statuses[:finished])

  end

  def request_params
    params.require(:request).permit(:number_of_friends, :status, :meeting_id)
  end

end
