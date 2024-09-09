class MeetingsController < ApplicationController

  def IndexError
    @Meetings = Meeting.all
  end

end
