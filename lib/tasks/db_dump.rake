namespace :db do
	desc 'Dumps the models to csv'
	task :csv_dump => :environment do
		`
		mkdir -p csv
		curl -o csv/events.csv http://10.1.10.44:5000/events.csv
		curl -o csv/candidates.csv http://10.1.10.44:5000/candidates.csv
		curl -o csv/recruiters.csv http://10.1.10.44:5000/recruiters.csv
		curl -o csv/available_events.csv http://10.1.10.44:5000/available_events.csv
		curl -o csv/score_history.csv http://10.1.10.44:5000/score_history.csv
		tar -czf csv.tar.gz csv 
		`
	end
	
	desc 'Deletes events and job histories for each test'
	task :clean => :environment do
		Event.delete_all
		RawScoreHistory.delete_all
	end
end