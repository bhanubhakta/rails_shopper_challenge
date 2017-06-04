class AddIndexToFunnelBatch < ActiveRecord::Migration
  def up
    add_index :funnel_batches, :start_date
    add_index :funnel_batches, :end_date
  end

  def down
    remove_index :funnel_batches, :start_date
    remove_index :funnel_batches, :end_date
  end
end
