class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts, id: :uuid do |t|
      t.string(:title)
      t.text(:content)
      t.uuid(:user_id)
      t.uuid(:community_id)

      t.timestamps
    end
  end
end
