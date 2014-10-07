class Tasker

	def self.all_current_tasks
		scale = 100
		(0...100).map do |r|
			{lower: r*scale, upper: ((r+1)*scale - 1)}
		end
	end

	def self.complete_task(task, results)
	end

end