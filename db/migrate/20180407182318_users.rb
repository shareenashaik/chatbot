class Users < ActiveRecord::Migration
  def change
  	create_table "users" do |t|
  		t.column :name, :string
  		t.column :email, :string
  	end
  	create_table "tickets" do |t|
  		t.column :sprint_id, :integer
  		t.column :title, :string
  		t.column :status, :integer
  		t.column :created_by, :integer
  	end
  	create_table "sprints" do |t|
  		t.column :title, :string
  		t.column :status, :string
  		t.column :start_date, :datetime
  		t.column :end_date, :datetime
  		t.column :created_by, :integer
  	end
  end
end
