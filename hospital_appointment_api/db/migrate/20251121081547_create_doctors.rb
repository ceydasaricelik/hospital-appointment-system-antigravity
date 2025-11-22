class CreateDoctors < ActiveRecord::Migration[8.0]
  def change
    create_table :doctors do |t|
      t.references :user, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :specialization
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
  end
end
