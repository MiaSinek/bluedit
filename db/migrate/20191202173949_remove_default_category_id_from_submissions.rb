class RemoveDefaultCategoryIdFromSubmissions < ActiveRecord::Migration[6.0]
  def change
    change_column_default :submissions, :community_id, nil
  end
end
