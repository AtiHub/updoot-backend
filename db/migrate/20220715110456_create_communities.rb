class CreateCommunities < ActiveRecord::Migration[7.0]
  def change
    create_table :communities, id: :uuid do |t|
      t.uuid(:creator_id)
      t.string(:name)
      t.string(:description)

      t.timestamps
    end
  end
end
