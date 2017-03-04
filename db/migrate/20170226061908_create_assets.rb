class CreateAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :assets do |t|
      t.integer :user_id
      t.string :file_upload

      t.timestamps
    end
  end

end
