task :score => :environment do
  weights = calc_pillar_wrights
  puts "recruiter weights = #{weights}"
end

def calc_pillar_wrights
  counts = {}.tap do |hash|
    Pillar.all.each do |pillar|
      hash[pillar.id] = Event.by(Recruiter).in_pillar(pillar).select("available_events.multiplier").map{|r| r.attributes['multiplier'].to_f}.sum if pillar.weight.nil?
    end
  end
  puts "recruiter counts = #{counts}"
  tot = counts.values.sum
  weights = {}.tap{|hash| Pillar.all.each{|pillar| hash[pillar.id] = pillar.weight unless  pillar.weight.nil?}}
  total_weight = 100 - weights.values.sum
  weights.tap{|hash| Pillar.all.each{|pillar| hash[pillar.id] = counts[pillar.id]*total_weight/tot if pillar.weight.nil?}}
end
