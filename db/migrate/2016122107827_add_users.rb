class AddUsers < ActiveRecord::Migration[5.0]
  def change
    create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.string   "slack_user_id",        null: false
      t.string   "slack_user_name",      null: false
      t.string   "slack_team_id",        null: false
      t.string   "epicmix_email"
      t.timestamps
    end
  end
end
