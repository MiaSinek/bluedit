class AddCommunityReferenceToSubmissions < ActiveRecord::Migration[6.0]
  def change
    #Using the previously set up General community as default community id for existing submissions
    general_community_id = Community.find_by(name: 'general').id

    add_reference :submissions, :community, foreign_key: true, default: general_community_id #, null: false

    # Adding null: false above results in
    #
    # SQLite3::SQLException: Cannot add a NOT NULL column with default value NULL
    #
    # Workaround - this works with Postgres, MySQL and SQLite
    # https://www.viget.com/articles/adding-a-not-null-column-to-an-existing-table/
    change_column_null :submissions, :community_id, false
  end
end
