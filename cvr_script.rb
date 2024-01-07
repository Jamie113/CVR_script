def validate_data_structure(reasons_with_data)
  unless reasons_with_data.all? { |_reason, data| data.key?(:percentage) && data.key?(:cvr) }
    raise 'Each reason must have a percentage and a CVR'
  end
end

def validate_total_percentage(reasons_with_data)
  total_percentage = reasons_with_data.sum { |_reason, data| data[:percentage] }
  raise 'Total percentage does not add up to 100' unless total_percentage == 100
end

def calculate_overall_cvr(reasons_with_data)
  validate_data_structure(reasons_with_data)
  validate_total_percentage(reasons_with_data)

  overall_cvr = reasons_with_data.reduce(0) do |total, (_reason, data)|
    total + (data[:percentage] * data[:cvr])
  end

  overall_cvr / 100.0
end

# Flows, traffic % and CVR
reasons_with_data = {
  "My plan is too expensive" => { percentage: 24, cvr: 65 },
  "I don't want a subscription" => { percentage: 14, cvr: 78 },
  "I am overstocked" => { percentage: 13, cvr: 59 },
  "I don't want to use it anymore" => { percentage: 10, cvr: 87 },
  "I haven't seen results" => { percentage: 10, cvr: 73 },
  "I have found a cheaper option" => { percentage: 9, cvr: 67 },
  "Other" => { percentage: 5, cvr: 75 },
  "Undefined" => { percentage: 4, cvr: 100 },
  "I am experiencing side effects" => { percentage: 4, cvr: 85 },
  "I am no longer in the UK" => { percentage: 3, cvr: 81 },
  "I had a problem using the product" => { percentage: 2, cvr: 70 },
  "I am understocked" => { percentage: 2, cvr: 66 }
}

total_cvr = calculate_overall_cvr(reasons_with_data)
puts "The overall CVR is: #{total_cvr.round(2)}%"
