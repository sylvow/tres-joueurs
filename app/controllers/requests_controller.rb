class RequestsController < ApplicationController

  helper_method :compute_players_needed
  before_action :set_request, only: [:edit, :update, :destroy]
  def index
    @meetings = Meeting.where(user_id: current_user)
    @my_requests = Request.where(user_id: current_user)
    @other_requests = Request.where(meeting_id: @meetings)

  end

  def show
    @request = Request.find(params[:id])
  end

  def create
    @meeting = Meeting.find(request_params[:meeting_id])
    @request = Request.new(request_params)
    @request.user = current_user
    @request.meeting = @meeting
    @request.status = "interested"
    if @request.save!
      redirect_to requests_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit

    @request = Request.find(params[:id])
    @status = ["En attente de validation", "Annuler"]
  end

  def update
    @request = Request.find(params[:id])
    if @request.update!(request_params) && request_params[:status] == "Annuler"
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
  def request_params
    params.require(:request).permit(:number_of_friends, :status, :meeting_id)
  end

end
