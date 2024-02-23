class AddUserDetails < ActiveRecord::Migration[7.1]
  def up
    create_table :user_details do |t|
      t.integer :title
      t.string :age
      t.string :phone
      t.string :email, null: false
      t.references :user, index: true
    end
  end

  def down
    drop_table :user_details
  end
end
