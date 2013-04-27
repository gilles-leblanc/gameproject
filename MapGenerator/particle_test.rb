require 'test/unit'
require_relative './particle'

class ParticleTest < Test::Unit::TestCase
	def test_drop_will_leave_a_particle_on_height_map
		# Arrange
		height_map = Array.new(100, 0)
		particle = Particle.new
		
		# Act
		particle.drop(height_map, 5, 5, 10)	
		
		# Assert
		assert(height_map.one? {|element| element == 1})
		assert(height_map.none? {|element| element > 1})
	end
	
	def test_drop_will_leave_a_particle_at_drop_point_if_no_other_particles
		# Arrange
		height_map = Array.new(100, 0)
		particle = Particle.new
		
		# Act
		particle.drop(height_map, 5, 5, 10)	
		
		# Assert
		assert_equal(height_map[55], 1)
		assert(height_map.none? {|element| element > 1})
	end
	
	def test_drop_will_not_leave_second_particle_on_top_of_first_particle
		# Arrange
		height_map = Array.new(100, 0)
		first_particle = Particle.new
		second_particle = Particle.new
		
		# Act
		first_particle.drop(height_map, 5, 5, 10)
		second_particle.drop(height_map, 5, 5, 10)	
		
		# Assert
		assert_equal(1, height_map[55])
		assert_equal(2, height_map.count {|element| element == 1})
		assert(height_map.none? {|element| element == 2})						
	end
	
	def test_drop_will_leave_second_particle_adjacent_to_first_particle
		# Arrange
		height_map = Array.new(100, 0)
		first_particle = Particle.new
		second_particle = Particle.new
		
		# Act
		first_particle.drop(height_map, 5, 5, 10)
		second_particle.drop(height_map, 5, 5, 10)	
		
		# Assert
		assert_equal(1, height_map[55])
		assert_equal(2, height_map.count {|element| element == 1})
		
		assert(height_map[4 + 5 * 10] ||
					 height_map[6 + 5 * 10] ||
					 height_map[4 + 4 * 10] ||
					 height_map[5 + 4 * 10] ||
					 height_map[6 + 4 * 10] || 
					 height_map[4 + 6 * 10] ||
					 height_map[5 + 6 * 10] ||
					 height_map[6 + 6 * 10])					
	end
	
	def test_drop_will_not_leave_third_particle_on_top_of_first_or_second_particle
		# Arrange
		height_map = Array.new(100, 0)
		
		# Act
		3.times do
			particle = Particle.new
			particle.drop(height_map, 5, 5, 10)
		end
		
		# Assert
		assert_equal(3, height_map.count {|element| element == 1})
		assert(height_map.none? {|element| element == 2})		
	end
			
	def test_drop_will_not_leave_fourth_particle_on_top_of_any_existing_particle
		# Arrange
		height_map = Array.new(100, 0)
		
		# Act
		4.times do
			particle = Particle.new
			particle.drop(height_map, 5, 5, 10)
		end
		
		# Assert
		assert_equal(4, height_map.count {|element| element == 1})
		assert(height_map.none? {|element| element == 2})		
	end		
			
	def test_drop_will_not_leave_ninth_particle_on_top_of_any_existing_particle
		# Arrange
		height_map = Array.new(100, 0)
		
		# Act
		9.times do
			particle = Particle.new
			particle.drop(height_map, 5, 5, 10)
		end
		
		# Assert
		assert_equal(9, height_map.count {|element| element == 1})
		assert(height_map.none? {|element| element == 2})		
	end
	
	def test_drop_will_leave_tenth_particle_on_top_of_first_particle
		# Arrange
		height_map = Array.new(100, 0)
		
		# Act
		10.times do
			particle = Particle.new
			particle.drop(height_map, 5, 5, 10)
		end
		
		# Assert
		assert_equal(2, height_map[55])
		assert(height_map.one? {|element| element == 2})
		assert(height_map.any? {|element| element == 1})
	end
	
	def test_drop_will_not_leave_eleventh_particle_on_top_of_first_and_tenth_particle
		# Arrange
		height_map = Array.new(100, 0)
		
		# Act
		11.times do
			particle = Particle.new
			particle.drop(height_map, 5, 5, 10)
		end
		
		# Assert
		assert_equal(2, height_map[55])
		assert_equal(2, height_map.count {|element| element == 2})
		assert_equal(7, height_map.count {|element| element == 1})
	end
	
	def test_drop_with_18_particles_will_make_9_stacks_of_2
		# Arrange
		height_map = Array.new(100, 0)
		
		# Act
		18.times do
			particle = Particle.new
			particle.drop(height_map, 5, 5, 10)
		end
		
		# Assert
		assert_equal(9, height_map.count {|element| element == 2})
		assert(height_map.none? {|element| element == 1})
	end
	
	def test_drop_with_stability_radius_2_with_10_particles_all_stacks_of_1
		# Arrange
		height_map = Array.new(100, 0)
		
		# Act
		10.times do
			particle = Particle.new(2)
			particle.drop(height_map, 5, 5, 10)
		end
		
		# Assert
		assert_equal(10, height_map.count {|element| element == 1})
		assert(height_map.none? {|element| element == 2})
	end
	
	def test_drop_with_stability_radius_2_with_25_particles_all_stacks_of_1
		# Arrange
		height_map = Array.new(100, 0)
		
		# Act
		25.times do
			particle = Particle.new(2)
			particle.drop(height_map, 5, 5, 10)
		end
		
		# Assert
		assert_equal(25, height_map.count {|element| element == 1})
		assert(height_map.none? {|element| element == 2})
	end
	
	def test_drop_with_stability_radius_2_will_leave_26th_particle_on_top_first
		# Arrange
		height_map = Array.new(100, 0)
		
		# Act
		26.times do
			particle = Particle.new(2)
			particle.drop(height_map, 5, 5, 10)
		end
		
		# Assert
		assert_equal(2, height_map[55])
		assert(height_map.one? {|element| element == 2})
		assert(height_map.none? {|element| element == 3})
		assert_equal(24, height_map.count {|element| element == 1})
	end
	
	def test_drop_with_stability_radius_2_with_50_particles_all_stacks_of_2
		# Arrange
		height_map = Array.new(100, 0)
		
		# Act
		50.times do
			particle = Particle.new(2)
			particle.drop(height_map, 5, 5, 10)
		end
		
		# Assert
		assert(height_map.none? {|element| element == 3})
		assert_equal(25, height_map.count {|element| element == 2})
	end
end
