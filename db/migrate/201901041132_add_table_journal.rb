class AddTableJournal < ActiveRecord::Migration[5.2]
  def change
    create_table :journals, :primary_key => :uuid do |t|
      t.string :uuid, :default => SecureRandom.uuid
      t.string :name
      t.text :description
    end
  end
end
