class EmailMessage < ApplicationRecord
  belongs_to :invoice

  validates :subject, :content, presence: true
end
