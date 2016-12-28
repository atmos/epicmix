# Encapsulates user standings per-team
class Leaderboard
  attr_reader :users
  def initialize(users)
    @users = users
  end

  def user_rows
    users.map { |u| [u.slack_user_name, u.vertical_feet] }
  end

  def ascii_table
    @ascii_table ||= Terminal::Table.new do |t|
      t << ["Name", "Vertical Feet"]
      t << :separator
      user_rows.each { |u| t.add_row u }
    end
  end

  def to_ascii_table
    ascii_table.to_s
  end
end
