require_relative 'src/Rules/battle_coordinator'
require_relative 'src/Rules/items/shields'
require_relative 'src/Rules/items/armors'
require_relative 'src/Rules/items/weapons'
require_relative 'src/Rules/mobs/goblin'
require_relative 'src/Rules/classes/knight'
require_relative 'src/Rules/classes/sorcerer'
require_relative 'src/Rules/stats'
require_relative 'src/Rules/party'
require_relative 'src/Rules/spells/spells'

padded_armor = PaddedArmor.new
shield = LargeShield.new
long_sword = LongSword.new
dagger = LongDagger.new

stats = Stats.new
stats.might, stats.accuracy, stats.endurance = 20, 20, 20
stats.intellect, stats.personality = 20, 20
stats.speed, stats.luck = 20, 20

felgar = Knight.new('Sir Felgar', stats)
felgar.paper_doll.equip(shield)
felgar.paper_doll.equip(padded_armor)
felgar.paper_doll.equip(long_sword)

cassandra = Sorcerer.new('Casssandra', stats)
cassandra.paper_doll.equip(padded_armor)
cassandra.paper_doll.equip(dagger)
cassandra.spells[1].push(FlameArrow.new)

party = Party.new
party.members.push(felgar)
party.members.push(cassandra)

random_number_generator = Random.new

enemies = []
enemies.push(Goblin.new(random_number_generator))
enemies.push(Goblin.new(random_number_generator))

battle_coordinator = BattleCoordinator.new

puts 'You are : '
party.members.each { |c| puts c.class.name + ' ' + c.name }
puts ' --- '
puts

puts 'You face : '
enemies.each { |e| puts e.name }
puts ' --- '
puts

battle_coordinator.run_battle(party, enemies)
