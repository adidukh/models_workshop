class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :address, null: false
      t.string :email, null: false
      t.string :password_digest
      t.integer :role, null: false, default: 0
      t.json :geodata, null: false, default: {}

      t.timestamps
    end
  end
end
