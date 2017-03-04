class CreateAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :assets do |t|
      t.integer :user_id
      t.string :name
      t.text :description
      t.string :file

      t.timestamps
    end
  end
  def up
    remove_column :assets, :name, :description
  end
  def down
    add_column :file_upload, :string
  end
end
