class AddTableItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items, primary_key: :uuid do |t|
      t.string :uuid, index: true, default: SecureRandom.uuid
      t.text :subscription

      t.references :journal, index: true, foreign_key: true
    end
  end
end
