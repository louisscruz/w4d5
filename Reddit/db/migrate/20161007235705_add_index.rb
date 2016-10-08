class AddIndex < ActiveRecord::Migration
  def change
    add_index :votes, :user_id
    add_index :votes, [:votable_type, :votable_id, :user_id], unique: true
  end
end
