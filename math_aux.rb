require "test/unit"

module MathAux
	def self.normalize(numbers, to=1.0)
		norm_rat = to / numbers.max
		numbers.map { |n| n * norm_rat }
	end
end

if __FILE__ == $0:
	class MathAuxTester < Test::Unit::TestCase
		def test_normalize
			assert_equal([0.5, 1.0, 0.25, 0], MathAux::normalize([24, 48, 12, 0]))
			assert_equal([40, 80, 20, 0], MathAux::normalize([24, 48, 12, 0], to=80.0))
		end
	end
end