class RequestsController < ApplicationController

  helper_method :compute_players
  before_action :set_request, except: [:index, :create]


  # CRUD methods
  def index
    @requests = current_user.meetings.joins(:requests)
    @user_meetings = Meeting.where(user_id: current_user).where.not(status: :cancelled).where.not(status: :finished)
    @requested_meetings = Meeting.joins(:requests).where(requests: { user_id: current_user }).where.not(requests: { status: :rejected })
    @user_meetings.each do |meeting|
      if meeting.date < Date.today
        meeting.finished!
        meeting.save!
      end
    end

    current_user.update(viewed_requests_count: 0) if current_user.viewed_requests_count.nil?
    current_user.update(viewed_requests_count: Request.where(meeting: current_user.meetings).count)
  end

  def show
  end

  def create
    @meeting = Meeting.find(params[:meeting_id])
    if Request.where(user_id: current_user.id, meeting_id: @meeting.id).exists? || @meeting.full?
      render json: { error: "You have already requested to join this meeting" }, status: :unprocessable_entity
    else
      @request = Request.new(request_params)
      @request.user = current_user
      @request.meeting = @meeting
      if request_params[:number_of_friends] == ""
        @request.number_of_friends = 0
      end
      @request.interested!
      if @request.save!
        @notification = Notification.new(
          notifiable_type: 'Meeting',
          notifiable_id: @request.meeting.id,
          category: 'pending-request',
          content: "Demande en attente d'approbation pour #{@request.meeting.game.name} le #{@request.meeting.date.strftime('%d/%m/%y')}")
        @notification.unread!
        @notification.save!
        redirect_to requests_path
      else
        redirect_to meeting_path(@meeting), status: :unprocessable_entity
      end
    end
  end

  def edit
  end

  def update
    if @request.update!(request_params)
      redirect_to requests_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def reject
    @request.status = Request.statuses[:rejected]
    redirect_to requests_path if @request.save!
  end

  def accept
    @request.status = Request.statuses[:accepted]
    @notification = Notification.new(
      notifiable_type: 'Request',
      notifiable_id: @request.id,
      category: 'approved-request',
      content: "Demande acceptée pour #{@request.meeting.game.name} le #{@request.meeting.date.strftime('%d/%m/%y')}")
    @notification.unread!
    @notification.save!
    redirect_to requests_path if @request.save!
  end

  def destroy
    @request.destroy
    redirect_to requests_path, status: :see_other
  end

  def cancel
    @request.rejected!
    redirect_to meetings_path
  end

  # Other methods

  def compute_players(meeting)
    counter = 0
    meeting.requests.where(status: :accepted).each do |e|
      counter += e.number_of_friends
    end
    counter + meeting.requests.where(status: :accepted).count + 1
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit(:number_of_friends, :status, :meeting_id)
  end
end
