module CumulativeRoundoff
private
  def roundoff(value)
    return 1.0 if value < 1.0 && value  > 0.998
    value
  end
end