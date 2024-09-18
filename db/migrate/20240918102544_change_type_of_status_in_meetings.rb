class ChangeTypeOfStatusInMeetings < ActiveRecord::Migration[7.1]
  def change
    add_column :meetings, :status_integer, :integer, default: 0

    # Mapper les anciennes valeurs vers les nouvelles
    Meeting.reset_column_information
    Meeting.find_each do |meeting|
      case meeting.status
      when 'available'
        meeting.update_column(:status_integer, 0)
      when 'full'
        meeting.update_column(:status_integer, 1)
      when 'ongoing'
        meeting.update_column(:status_integer, 2)
      when 'cancelled'
        meeting.update_column(:status_integer, 3)
      when 'finished'
        meeting.update_column(:status_integer, 4)
      else
        meeting.update_column(:status_integer, 0)
      end
    end

    # Supprimer l'ancienne colonne
    remove_column :meetings, :status

    # Renommer la colonne temporaire
    rename_column :meetings, :status_integer, :status
  end
end
