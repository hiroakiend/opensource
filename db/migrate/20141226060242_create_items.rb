class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :client
      t.text :client_info
      t.string :subject
      t.text :description
      t.string :status
      t.text :proceedings
      t.string :notes
      t.integer :initial_price
      t.integer :running_price
      t.date :start_date
      t.date :end_date
      t.date :delivery
      t.string :introducer

      t.timestamps
    end
  end
end
