class CreateFaqs < ActiveRecord::Migration[5.1]
  def change
    create_table :faqs do |t|
      t.string :question
      t.string :answer
      t.integer :company_id, index: true, foreign_key: true
    end
  end
end
