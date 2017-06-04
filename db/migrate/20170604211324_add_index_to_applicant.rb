class AddIndexToApplicant < ActiveRecord::Migration
  def up
    add_index :applicants, :updated_at
  end

  def down
    remove_index :applicants, :updated_at
  end
end
