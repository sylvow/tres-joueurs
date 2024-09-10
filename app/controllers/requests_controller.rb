class RequestsController < ApplicationController


  def create
    @meeting = Meeting.find(request_params[:meeting_id])
    @request = Request.new(request_params)
    @request.user = current_user
    if @request.save!
      redirect_to requests_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @requests = Request.where(user_id: current_user)
    @meetings = Meeting.where(user_id: current_user)
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
    @request = Request.find(params[:id])
    @request.destroy
    redirect_to requests_path, status: :see_other
  end

  private

  def request_params
    params.require(:request).permit(:number_of_friends, :status, :meeting_id)
  end

end
