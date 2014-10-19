module TimeHelper

  def seconds_to_string(s)
    m = (s / 60).floor
    s = s % 60
    h = (m / 60).floor
    m = m % 60
    d = (h / 24).floor
    h = h % 24

    result = ''

    result << "#{d} day#{pluralize(d)}" if d > 0
    result << ', ' if !result.empty? && h > 0
    result << "#{h} hour#{pluralize(h)}" if h > 0
    result << ', ' if !result.empty? &&  m > 0
    result << "#{m} minute#{pluralize(m)}" if m > 0
    result << ', ' if !result.empty? && s > 0
    result << "#{s} second#{pluralize(s)}" if s > 0

    result
  end

  def pluralize(number)
    if number == 1
      ''
    else
      's'
    end
  end

end