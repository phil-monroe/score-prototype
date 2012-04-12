task :score, [:use_last_period] => [:environment] do |t, args|
  #Constants that need admin in the final implementations
  MAX_SCORE = 100
  MIN_SCORE = 1
  R_VAL = 0.15
  P_VAL = 2.0

  CalculationTimeHistory.create(time: Time.now) unless args[:use_last_period]

  range = CalculationTimeHistory.last(2).map(&:time)
  puts "time period used = #{range}"

  weights = calc_pillar_wrights range
  puts "recruiter weights = #{weights}"

  maxs = get_pillar_maxs range
  puts "pillar maxs = #{maxs}"

  Candidate.active_in(range).each do |candidate|
    scores = {}
    scores_unnormalized = {}
    Pillar.all.each do |pillar|
      activity = Event.total_activity(candidate, pillar, range)
      scores[pillar.id] = scores_unnormalized[pillar.id] = maxs[pillar.id] > 0 ? weights[pillar.id] * activity / maxs[pillar.id] : 0
      #scores[pillar.id] =(20.0 / (((1 + (20.0 / MIN_SCORE)) * (Math::E**(-R_VAL*scores_unnormalized[pillar.id])))**P_VAL))
    end
    candidate.raw_score_histories.build(score: [scores.values.sum, MAX_SCORE].min, pillars: scores).save
    puts "#{candidate.id} -> #{scores_unnormalized} -> #{scores} => #{[scores.values.sum, MAX_SCORE].min}"
  end

  AVERAGING_LENGTH = 5
  averaging_range = CalculationTimeHistory.last(AVERAGING_LENGTH+1).map(&:time)
  Candidate.active_in(averaging_range).each do |candidate|
    candidate.score = candidate.raw_score_histories.where("created_at > ?", averaging_range[1]).map(&:score).sum/AVERAGING_LENGTH
    candidate.save
    puts "#{candidate.id} -> #{candidate.score}"
  end
end

def get_pillar_maxs range
  pillars = Pillar.all
  maxs = {}
  pillars.each{|pillar| maxs[pillar.id] = 0}
  maxs.tap do |maxs|
    Candidate.active_in(range).each do |candidate|
      activity = {}
      pillars.each do |pillar|
        activity[pillar.id] = Event.total_activity(candidate, pillar, range)
        maxs[pillar.id] = activity[pillar.id] if maxs[pillar.id] < activity[pillar.id]
      end
      puts "#{candidate.id} -> #{activity}"
    end
  end
end

def calc_pillar_wrights range
  counts = {}.tap do |hash|
    Pillar.all.each do |pillar|
      hash[pillar.id] = Event.total_activity(Recruiter, pillar, range) if pillar.weight.nil?
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

  total_weight = 100.0 - weights.values.sum
  # Note: if recruiters have had no activity during the period the distribution is equal
  weights.tap do |hash|
    Pillar.all.each do |pillar|
      hash[pillar.id] = (tot > 0 ? counts[pillar.id]*total_weight/tot : total_weight/dynamic_pillars) if pillar.weight.nil?
      hash[pillar.id] /= 100.0
    end
  end
end
