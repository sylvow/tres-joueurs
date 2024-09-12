class Request < ApplicationRecord
  enum status: { interested: "En attente de validation", accepted: "Validé", rejected: "Annuler" }

  belongs_to :meeting
  belongs_to :user
end
