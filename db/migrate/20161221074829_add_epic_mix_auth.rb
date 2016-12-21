class AddEpicMixAuth < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :enc_epicmix_password, :string, null: true
  end
end
