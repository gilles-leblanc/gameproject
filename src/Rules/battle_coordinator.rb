require_relative '../broadcast'

# Coordinates battles between the party (the characters)
# and a group of monsters
class BattleCoordinator
  include Broadcast

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
          participant.attack(target)
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
