class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams, id: :uuid do |t|
      t.string "slack_team_id", null: false
      t.string "slack_team_name"

      t.timestamps
    end

    add_column :users, :team_id, :uuid, null: false
  end
end
