class DropPollVotes < ActiveRecord::Migration
  def self.up
    drop_table :poll_votes
  end

  def self.down
    create_table :poll_votes do |t|
      t.column :votes, :integer
      t.column :project_id, :integer
      t.column :user_id, :integer
      t.timestamps
    end
  end
end
