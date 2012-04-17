task :score_server, :time, :simulate do |t, args|
	time = args[:time].to_i || 30
	simulate = args[:simulate] || false
	
	puts time.inspect
	while true do
		begin
			Rake::Task['score'].invoke
			Rake::Task['score'].reenable
		
			if simulate
				puts 'Simulating recruiter events'
				Rake::Task['random_recruiter_events'].invoke
				Rake::Task['random_recruiter_events'].reenable
			end
			sleep time
		rescue Exception => e
			puts "FAIl !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
			puts e.message
			if e.is_a?(Interrupt)
				exit()
			end
		end
	end
end


task :score, [:use_last_period] => [:environment] do |t, args|
  #Constants that need admin in the final implementations
  MAX_SCORE = 100
  MIN_SCORE = 1
  R_VAL = 0.095
  P_VAL = 0.85

  CalculationTimeHistory.create(time: Time.now) unless args[:use_last_period]

  range = CalculationTimeHistory.last(2).map(&:time)
  puts "time period used = #{range}"

  weights = calc_pillar_wrights range
  puts "recruiter weights = #{weights}"

  maxs = get_pillar_maxs range
  puts "pillar maxs = #{maxs}"

  Candidate.all.each do |candidate|
    scores = {}
    scores_unnormalized = {}
    scores_raw = {}
    scores_unnormalized_raw = {}
    Pillar.all.each do |pillar|
      activity = Event.total_activity(candidate, pillar, range)
      scores_unnormalized_raw[pillar.name] = scores_unnormalized[pillar.name] = maxs[pillar.name] > 0 ? activity / maxs[pillar.name] : 0
      scores_raw[pillar.name] = scores[pillar.name] = (100.0 / ((1 + (100.0 / MIN_SCORE) * (Math::E**(-R_VAL*100.0*scores_unnormalized[pillar.name])))**P_VAL))/100
      scores_unnormalized[pillar.name] *= weights[pillar.name]
      scores[pillar.name] *= weights[pillar.name]
    end
    candidate.raw_score_histories.build(raw_score: [scores.values.sum, MAX_SCORE].min, pillars: scores).save
    puts "#{candidate.id} -> #{scores_unnormalized_raw} -> #{scores_raw} => #{[scores.values.sum, MAX_SCORE].min}"
  end

  AVERAGING_LENGTH = 5
  averaging_range = CalculationTimeHistory.last(AVERAGING_LENGTH+1).map(&:time)
  Candidate.all.each do |candidate|
    candidate.score = candidate.raw_score_histories.where("created_at > ?", averaging_range[1]).map(&:raw_score).sum/AVERAGING_LENGTH
    latest = candidate.raw_score_histories.last
    latest.score = candidate.score
    latest.save
    candidate.save
    puts "#{candidate.id} -> #{candidate.score}"
  end
end

def get_pillar_maxs range
  pillars = Pillar.all
  maxs = {}
  pillars.each{|pillar| maxs[pillar.name] = 0}
  maxs.tap do |maxs|
    Candidate.all.each do |candidate|
      activity = {}
      pillars.each do |pillar|
        activity[pillar.name] = Event.total_activity(candidate, pillar, range)
        maxs[pillar.name] = activity[pillar.name] if maxs[pillar.name] < activity[pillar.name]
      end
      puts "#{candidate.id} -> #{activity}"
    end
  end
end

def calc_pillar_wrights range
  counts = {}.tap do |hash|
    Pillar.all.each do |pillar|
      hash[pillar.name] = Event.total_activity(Recruiter, pillar, range) if pillar.weight.nil?
    end
  end
  puts "recruiter counts = #{counts}"

  tot = counts.values.sum
  dynamic_pillars = 0

  weights = {}.tap do |hash|
    Pillar.all.each do |pillar|
      pillar.weight.nil? ?
          dynamic_pillars+=1 :
          hash[pillar.name] = pillar.weight
    end
  end

  total_weight = 100.0 - weights.values.sum
  # Note: if recruiters have had no activity during the period the distribution is equal
  weights.tap do |hash|
    Pillar.all.each do |pillar|
      hash[pillar.name] = (tot > 0 ? counts[pillar.name]*total_weight/tot : total_weight/dynamic_pillars) if pillar.weight.nil?
      hash[pillar.name] /= 100.0
    end
  end
end
