task :score => :environment do
  weights = calc_pillar_wrights
  puts "recruiter weights = #{weights}"

  maxs = get_pillar_maxs
  puts "pillar maxs = #{maxs}"


end

def get_pillar_maxs
  pillars = Pillar.all
  maxs = {}
  pillars.each{|pillar| maxs[pillar.id] = 0}
  maxs.tap do |maxs|
    Candidate.all.each do |candidate|
      activity = {}
      pillars.each do |pillar|
        activity[pillar.id] = Event.by(candidate).in_pillar(pillar).select("sum(available_events.multiplier) as sum").map(&:attributes).first['sum']
        maxs[pillar.id] = activity[pillar.id] if maxs[pillar.id] < activity[pillar.id]
      end
      puts "#{candidate.id} -> #{activity}"
    end
  end
end

def calc_pillar_wrights
  counts = {}.tap do |hash|
    Pillar.all.each do |pillar|
      hash[pillar.id] = Event.by(Recruiter).in_pillar(pillar).select("sum(available_events.multiplier) as sum").map(&:attributes).first['sum'] if pillar.weight.nil?
    end
  end
  puts "recruiter counts = #{counts}"

  tot = counts.values.sum
  dynamic_pillars = 0

  weights = {}.tap do |hash|
    Pillar.all.each do |pillar|
      pillar.weight.nil? ?
          dynamic_pillars+=1 :
          hash[pillar.id] = pillar.weight
    end
  end

  total_weight = 100 - weights.values.sum

  # Note: if recruiters have had no activity during the period the distribution is equal
  weights.tap do |hash|
    Pillar.all.each do |pillar|
      hash[pillar.id] = (tot > 0 ? counts[pillar.id]*total_weight/tot : total_weight/dynamic_pillars) if pillar.weight.nil?
    end
  end
end
