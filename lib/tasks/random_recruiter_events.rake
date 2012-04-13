task :random_recruiter_events => :environment do
  (1..3).each do |id|
    me = Recruiter.find(id) rescue Recruiter.new(name:"New Candidate")
    me.save!
    if rand(100) < 30
      AvailableEvent.where(:user_type => Candidate).all.each do |ae|
        r = rand(30)
        r.times{Event.new(user: me, available_event: ae).save}
      end
    end
  end
end

task :random_candidate_events => :environment do
  (1..10).each do |id|
    me = Candidate.find(id) rescue Candidate.new(name:"New Candidate")
    me.save!
    if rand(100) < 30
      AvailableEvent.where(:user_type => Candidate).all.each do |ae|
        r = rand(30)
        r.times{Event.new(user: me, available_event: ae).save}
      end
    end
  end
end

task :simulate_cycle => [:environment, :random_recruiter_events, :random_candidate_events, :score]

task :simulate do
  while true
    sleep 5.seconds
    `rake simulate_cycle`
  end
end
