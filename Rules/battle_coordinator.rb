require_relative 'items/shields'
require_relative 'items/armors'
require_relative 'items/weapons'
require_relative 'mobs/goblin'
require_relative 'classes/knight'
require_relative 'classes/sorcerer'
require_relative 'stats'
require_relative '../broadcast'
require_relative 'party'
require_relative 'spells/spells'

# Coordinates battles between the party (the characters)
# and a group of monsters
class BattleCoordinator
  include Broadcast

  def initialize(random)
    @random = random
  end

  def run_battle(party, enemies)
    participants = party.members + enemies
    participants.sort_by! { |p| p.stats.speed }.reverse!

    while party.members.any? { |p| p.current_hp > 0 } &&
        enemies.any? { |e| e.current_hp > 0 }
      participants.each do |participant|
        if party.members.any? { |p| p.equal? participant }
          # we are dealing with a party member
          participant.act(enemies)
        else
          # we are dealing with an enemy
          target = party.members.select { |m| m.current_hp > 0 }.shuffle.first
          participant.attack(target, @random)
        end

        participants.delete_if { |p| p.current_hp <= 0 }

        if party.members.all? { |m| m.current_hp <= 0 }
          return game_over
        end

        if enemies.all? { |m| m.current_hp <= 0 }
          return party_wins(party, enemies)
        end
      end
    end

    broadcast 'Battle terminated irregularly.'
  end

  def game_over
    broadcast 'The party has been defeated.'
    broadcast 'Game over.'
    false
  end

  def party_wins(party, enemies)
    broadcast 'The party wins the battle.'

    xp_gain = enemies.reduce(0) { |a, e| a + e.xp } / party.members.length
    party.members.each { |member| member.xp += xp_gain }
    broadcast "Party members each gain #{xp_gain} xp."

    # treasure
    loot = enemies.map { |enemy| enemy.treasure }
    broadcast loot
    # gold = loot.reduce(0) { |a, e| a + e[:gold] }

    true
  end
end

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

battle_coordinator = BattleCoordinator.new(random_number_generator)

puts 'You are : '
party.members.each { |c| puts c.class.name + ' ' + c.name }
puts ' --- '
puts

puts 'You face : '
enemies.each { |e| puts e.name }
puts ' --- '
puts

battle_coordinator.run_battle(party, enemies)
