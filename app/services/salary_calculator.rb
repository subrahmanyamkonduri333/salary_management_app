class SalaryCalculator
  def self.calculate(employee, gross)
    case employee.country
    when "India"
      tds = (gross * 0.10).to_i
    when "United States"
      tds = (gross * 0.12).to_i
    else
      tds = 0
    end

    {
      tds: tds,
      net: gross - tds
    }
  end
end
