task :random_recruiter_events => :environment do
  rme = Recruiter.last
  if rme.nil?
    rme = Recruiter.new(name:"New Recruiter").save!
  end
  AvailableEvent.where(:user_type => Recruiter).all.each do |ae|
    r = rand(100)
    r.times{Event.new(user: rme, available_event: ae).save}
  end

end
