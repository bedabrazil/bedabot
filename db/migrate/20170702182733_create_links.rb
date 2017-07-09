class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.string :url
      t.string :description
      t.integer :company_id, index: true, foreign_key: true
    end    
  end
end
