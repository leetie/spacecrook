class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.integer :sent_to
      t.integer :sent_by
      t.boolean :status, default: false
      t.timestamps
    end
  end
end
