class AddViewedRequestsCountToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :viewed_requests_count, :integer
  end
end
