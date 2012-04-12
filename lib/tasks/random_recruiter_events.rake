task :random_recruiter_events => :environment do
  rme = Recruiter.last
  if rme.nil?
    rme = Recruiter.new(name:"New Recruiter")
    rme.save!
  end
  AvailableEvent.where(:user_type => Recruiter).all.each do |ae|
    r = rand(100)
    r.times{Event.new(user: rme, available_event: ae).save}
  end
end

task :random_candidate_events => :environment do
  (1..10).each do |id|
    me = Candidate.find(id) rescue Candidate.new(name:"New Candidate")
    me.save!
    AvailableEvent.where(:user_type => Candidate).all.each do |ae|
      r = rand(30)
      r.times{Event.new(user: me, available_event: ae).save}
    end
  end
end

task :simulate_cycle => [:environment, :random_recruiter_events, :random_candidate_events, :score]
