class Request < ApplicationRecord
  enum status: { interested: "En attente de validation", accepted: "Validé", rejected: "Annulé" }

  # validates :meeting_id, uniqueness: { scope: :user_id, alert: "Vous avez déjà fait une demande pour cette partie", condidions: -> { where(status: "Annuler") } }


  belongs_to :meeting
  belongs_to :user
end
