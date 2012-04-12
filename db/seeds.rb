edu = Pillar.create name: "Education"
wrk = Pillar.create name: "Work"
net = Pillar.create name: "Network"

AvailableEvent.create user_type: "Candidate", event_name: "Add Work Item", pillar: wrk
AvailableEvent.create user_type: "Candidate", event_name: "Add Education Item", pillar: edu
AvailableEvent.create user_type: "Candidate", event_name: "Add Network Friend", pillar: net

AvailableEvent.create user_type: "Recruiter", event_name: "Search For Work Item", pillar: wrk
AvailableEvent.create user_type: "Recruiter", event_name: "Search For Education Item", pillar: edu
AvailableEvent.create user_type: "Recruiter", event_name: "Search For Candidate", pillar: net

CalculationTimeHistory.create time: Time.now
