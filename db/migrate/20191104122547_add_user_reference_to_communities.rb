class AddUserReferenceToCommunities < ActiveRecord::Migration[6.0]
  # TODO (for long winter nights): make null: false work below
  # See previous migration for workaround

  def change
    add_reference :communities, :user, foreign_key: true #, null: false
  end
end
