require "test/unit"
require "math_aux"

class ChartDSL
	
	Template = %(<table border="0" cellspacing="5" cellpadding="5"><caption>%%CAPTION%%</caption>%%ITEMS%%</table>)
	Background_colors = %w(red blue green yellow grey)
	
	attr_reader :values
	def initialize
		@charts ||= Array.new
		@values ||= Hash.new
	end
	
	def chart(name)		
		@name = name
		yield self
		@charts.push(make_html)
	end
	
	def add(name_and_value)
		@values ||= Hash.new
 		@values.merge!(name_and_value)
	end
	
	def load(filename)
		# c = new
		instance_eval(File.read(filename), filename)
		write_output
	end

	def make_html
		sorted_pairs = @values.sort_by { |v| - v[1] }
		vals = sorted_pairs.map { |p| p[1] }
		norm_values = MathAux::normalize(vals, 100.0)
		html = Array.new
		sorted_pairs.each_with_index do |pair, i|
			name, value = pair
			html.push(%Q(<tr><td>#{name}</td><td><div style="width:#{norm_values[i]}px;background-color:#{ChartDSL::Background_colors[i]}">&nbsp;</div></td><td>#{value}</td></tr>))
		end
		filled_chart = ChartDSL::Template.sub("%%CAPTION%%", @name)		
		filled_chart.sub("%%ITEMS%%", html.join)
	end
	
	def write_output
		File.open("generated_charts.html", "w") do |f|
			f.write(@charts)
		end
	end
end

if __FILE__ == $0
	class ChartDSLTester < Test::Unit::TestCase
    def test_makes_html_chart
    end
	end
end