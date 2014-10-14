class CreateWorkers < ActiveRecord::Migration
  def change
		create_table :workers do |t|
			t.string :ip
			t.datetime :last_request
			t.integer :requested
			t.integer :completed

			t.timestamps
		end

		add_index :workers, :ip
  end
end
