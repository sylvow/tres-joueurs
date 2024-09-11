class RequestsController < ApplicationController
  before_action :set_request, only: [:edit, :update, :destroy]

  def create
    @meeting = Meeting.find(params[:meeting_id])
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

  def index
    @meetings = Meeting.where(user: current_user)
    @requests = @meetings.requests
  end

  def edit
  end

  def update
    if @request.update!(request_params)
      redirect_to request_path(@request)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @request.destroy
    redirect_to requests_path, status: :see_other
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end
  def request_params
    params.require(:request).permit(:number_of_friends, :status)
  end

end
