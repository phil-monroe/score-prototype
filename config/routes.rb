ScoreProto::Application.routes.draw do
  resources :candidates
  resources :recruiters
	resources :available_events
	resources :events
  
  match 'login' => 'site#create'
  root to: "site#new"
end
