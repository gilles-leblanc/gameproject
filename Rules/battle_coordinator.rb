require_relative 'items/shields'
require_relative 'items/armors'
require_relative 'items/weapons'
require_relative 'mobs/goblin'
require_relative 'knight'
require_relative 'sorcerer'
require_relative 'stats'
require_relative '../broadcast'
require_relative 'party'

class BattleCoordinator
	include Broadcast
	
	def run_battle(party, enemies)
		participants = party.members + enemies
		participants.sort_by! {|p| p.speed}.reverse!
		
		while party.members.any? {|p| p.hp > 0} && enemies.any? {|e| e.hp > 0} 
			participants.each do |participant|				
				if party.members.any? {|p| p.equal? participant}
					# we are dealing with a party member
					participant.act(enemies)		
				else
					# we are dealing with an enemy
					target = party.members.select {|m| m.hp > 0}.shuffle.first
					participant.attack(target)
				end

				participants.delete_if {|p| p.hp <= 0}
				
				if party.members.all? {|m| m.hp <= 0}
					return game_over
				end
			
				if enemies.all? {|m| m.hp <= 0}
					return party_wins(party, enemies)
				end
			end			
		end	
		
		broadcast "Battle terminated irregularly."	
	end
	
	def game_over
		broadcast "The party has been defeated."
		broadcast "Game over."
		false
	end
	
	def party_wins(party, enemies)
		broadcast "The party wins the battle."
		
		xp_gain = enemies.inject(0) {|sum, e| sum + e.xp} / party.members.length 
		party.members.each {|member| member.xp += xp_gain}
		broadcast "Party members each gain #{xp_gain} xp."
									
		# treasure	
		loot = enemies.collect {|enemy| enemy.treasure}
		broadcast loot
		#gold = loot.inject(0) {|sum, l| sum + l[:gold]}
									
		true
	end
end

padded_armor = PaddedArmor.new
shield = LargeShield.new
long_sword = LongSword.new
dagger = LongDagger.new

stats = Stats.new
stats.might, stats.accuracy, stats.endurance, stats.intellect, stats.personality, stats.speed, stats.luck = 10, 10, 10, 10, 10, 10, 10

felgar = Knight.new("Sir Felgar", stats)
felgar.paper_doll.equip(shield)
felgar.paper_doll.equip(padded_armor)
felgar.paper_doll.equip(long_sword)

cassandra = Sorcerer.new("Casssandra", stats)
cassandra.paper_doll.equip(padded_armor)
cassandra.paper_doll.equip(dagger)

party = Party.new
party.members.push(felgar)
party.members.push(cassandra)

enemies = Array.new
enemies.push(Goblin.new)
enemies.push(Goblin.new)

battleCoordinator = BattleCoordinator.new

puts "You are : "
party.members.each {|c| puts c.class.name + ' ' + c.name}
puts " --- "
puts

puts "You face : "
enemies.each {|e| puts e.name}
puts " --- "
puts

battleCoordinator.run_battle(party, enemies)
