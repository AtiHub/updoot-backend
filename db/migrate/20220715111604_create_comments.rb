class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments, id: :uuid do |t|
      t.string(:title)
      t.text(:content)
      t.uuid(:user_id)
      t.uuid(:post_id)

      t.timestamps
    end
  end
end
