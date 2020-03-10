class Normalizer
  def self.percentage(str)
    return 100.to_f if str == "✓"

    str.to_f == 0.0 ? 0.01 : str.to_f
  end

  def self.team_name(str)
    str = str.gsub(".", "")
    case str
    when "Arizona State" then "Arizona St"
    when "Florida State" then "Florida St"
    when "Georgia State" then "Georgia St"
    when "Michigan State" then "Michigan St"
    when "Miss State" then "Mississippi St"
    when "Murray State" then "Murray St"
    when "UC-Irvine" then "UC Irvine"
    else
      str
    end
  end
end
