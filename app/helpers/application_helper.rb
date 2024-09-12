module ApplicationHelper
  def meeting_status_class(status)
    case status
    when 'disponible'
      'bg-success'
    when 'en cours'
      'bg-grey'
    when 'complet'
      'bg-danger'
    else
      'bg-success'
    end
  end
end
