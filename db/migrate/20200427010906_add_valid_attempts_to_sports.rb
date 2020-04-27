class AddValidAttemptsToSports < ActiveRecord::Migration[5.2]
  def change
    add_column :sports, :valid_attempts, :integer, default: 1
  end
end
