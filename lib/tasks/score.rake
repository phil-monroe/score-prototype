task :score => :environment do
  weights = calc_pillar_wrights
  puts "recruiter weights = #{weights}"

  maxs = get_pillar_maxs
  puts "pillar maxs = #{maxs}"

  Candidate.all.each do |candidate|
    scores = {}
    Pillar.all.each do |pillar|
      scores[pillar.id] = weights[pillar.id] * Event.total_activity(candidate, pillar) / maxs[pillar.id] if maxs[pillar.id] > 0
    end
    candidate.score = scores.values.sum
    puts "#{candidate.id} -> #{scores} => #{candidate.score}"
    candidate.save!
  end
end

def get_pillar_maxs
  pillars = Pillar.all
  maxs = {}
  pillars.each{|pillar| maxs[pillar.id] = 0}
  maxs.tap do |maxs|
    Candidate.all.each do |candidate|
      activity = {}
      pillars.each do |pillar|
        activity[pillar.id] = Event.total_activity(candidate, pillar)
        maxs[pillar.id] = activity[pillar.id] if maxs[pillar.id] < activity[pillar.id]
      end
      puts "#{candidate.id} -> #{activity}"
    end
  end
end

def calc_pillar_wrights
  counts = {}.tap do |hash|
    Pillar.all.each do |pillar|
      hash[pillar.id] = Event.total_activity(Recruiter, pillar) if pillar.weight.nil?
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
      hash[pillar.id] /= 100
    end
  end
end
