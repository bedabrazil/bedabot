class CreateFaqHashtags < ActiveRecord::Migration[5.1]
  def change
    create_table :faq_hashtags do |t|
      t.integer :faq_id, index: true, foreign_key: true
      t.integer :hashtag_id, index: true, foreign_key: true
    end
  end
end
