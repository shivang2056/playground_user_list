class AddUsers < ActiveRecord::Migration[7.1]
  def up
    create_table :users do |t|
      t.string :guid, null: false
      t.string :name, null: false
    end

    add_index :users, :name, unique: true
  end

  def down
    drop_table :users
  end
end
