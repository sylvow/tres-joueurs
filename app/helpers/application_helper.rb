module ApplicationHelper
  def meeting_status_class(status)
    case status
    when 'available'
      'bg-success'
    when 'ongoing'
      'bg-success'
    when 'full'
      'bg-success'
    when 'success'
      'bg-success'
    else
      'bg-success'
    end
  end
end
