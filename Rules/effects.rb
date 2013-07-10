# Module to control effects
module Effects
  # This method decrease of effects timer by 1 and remove effects which have a resulting timer of 1
  def Effects.update_effects_timers(effects)
    effects.each_value { |value| value.each { |effect| effect[1] -= 1 } }
    effects.each_value { |value| value.delete_if { |effect| effect[1] <= 0 } }
  end
end