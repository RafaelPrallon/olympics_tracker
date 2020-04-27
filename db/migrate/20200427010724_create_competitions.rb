class CreateCompetitions < ActiveRecord::Migration[5.2]
  def change
    create_table :competitions do |t|
      t.string :name
      t.belongs_to :sport
      t.integer :status
      t.timestamps
    end
  end
end
