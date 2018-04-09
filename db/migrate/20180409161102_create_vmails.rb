class CreateVmails < ActiveRecord::Migration
  def change
    create_table :vmails do |t|
      t.text :body
      t.text :subject
      t.timestamps null: false
    end
  end
end
