class CreateLinkHashtags < ActiveRecord::Migration[5.1]
  def change
    create_table :link_hashtags do |t|
      t.integer :link_id, index: true, foreign_key: true
      t.integer :hashtag_id, index: true, foreign_key: true
    end
  end
end
