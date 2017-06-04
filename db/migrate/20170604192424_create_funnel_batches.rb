class CreateFunnelBatches < ActiveRecord::Migration
  def up
    create_table :funnel_batches do |t|
      t.date :start_date, primary_key: true
      t.date :end_date
      t.string :range
      t.integer :applied
      t.integer :quiz_started
      t.integer :quiz_completed
      t.integer :onboarding_requested
      t.integer :onboarding_completed
      t.integer :hired
      t.integer :rejected
    end
  end

  def down
    drop_table :funnel_batches
  end
end