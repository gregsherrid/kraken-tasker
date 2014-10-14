require "./worker/kraken_worker.rb"
class Worker
	extend KrakenWorker

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
end

Worker.worker_loop