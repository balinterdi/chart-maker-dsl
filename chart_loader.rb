require "chart"

class ChartLoader
	def self.load_chart(dsl_filename)
		c = ChartDSL.new
		c.load(dsl_filename)
	end
end

if __FILE__ == $0
	ChartLoader.load_chart(ARGV[0])
end

	