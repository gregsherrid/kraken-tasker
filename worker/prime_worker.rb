# (c) Gregory Sherrid, 2014-10-7

class Worker

	def self.work(task)
		task.map do |val|
			if val >= 2
				max = Math.sqrt(val).floor
				flag = true
				(2..max).to_a.each do |factor|
					if val % factor == 0
						flag = false
						break
					end
				end
				flag
			else
				false
			end
		end
	end

	# test
	# puts work([0,1,2,3,4,5,6,7,8,9])
end