class Sport < ApplicationRecord
  enum victory_rule: %w(asc desc)

  validates_presence_of :name, :victory_rule
  validates :victory_rule, inclusion: { in: %w(asc desc) }
  validates :valid_attempts, numericality: { only_integer: true, greater_than: 0 }

  has_many :competitions
end
