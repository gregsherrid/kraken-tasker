class CreateIntegerForPrimes < ActiveRecord::Migration
	def change
		create_table :integer_for_primes do |t|
			t.integer :value
			t.boolean :prime

			t.timestamps
		end

		add_index :integer_for_primes, :value
	end
end
