# (c) Gregory Sherrid, 2014-10-7

class Tasker
	def self.get_task
		IntegerForPrime.where("prime IS NULL").sample(100).map(&:value)
	end

	def self.complete_task(task, results)
		task.each_with_index do |int,i|
			is_prime = results[i]
			ifp = IntegerForPrime.find_by(value: int)
			if !ifp.nil?
				ifp.update_column(:prime, is_prime)
			end
		end
	end

	def self.task_info
		total = IntegerForPrime.count
		processed = IntegerForPrime.where("prime IS NOT NULL").count
		progress = (processed.to_f / total).round(2)
		primes = IntegerForPrime.where("prime IS TRUE").count
		["Integers loaded: #{total}",
			"Integers processed: #{processed}, (#{progress})",
			"Primes Found: #{primes}"].join("<br>")
	end
end

class IntegerForPrime < ActiveRecord::Base
	SEARCH_MAX = 100000

	def self.load_integers
		(2..SEARCH_MAX).to_a.each_with_index do |val,i|
			puts "Loading #{val}..." if i%100 == 0
			IntegerForPrime.create(value: val)
		end
		true
	end
end