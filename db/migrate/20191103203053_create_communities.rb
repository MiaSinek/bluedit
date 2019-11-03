class CreateCommunities < ActiveRecord::Migration[6.0]
  def up
    create_table :communities do |t|
      t.string :name
      t.string :title
      t.text :description
      t.text :sidebar

      t.timestamps
    end

    add_index :communities, :name, unique: true

    Community.create(
      name: 'general',
      title: 'General Community',
      description: 'All submissions without community wind up here',
      sidebar: ''
    )
  end

  def down
    Community.find_by(name:'general').destroy

    remove_index :communities, :name

    drop_table :communities
  end
end
