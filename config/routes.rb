ScoreProto::Application.routes.draw do
	match 'score_history' => 'raw_score_histories#index'
  resources :candidates do
    resources :raw_score_histories
    resources :energy
  end
  resources :recruiters
	resources :available_events
  resources :events
	resources :calculation_time_history

  namespace :admin do
    resources :available_events do as_routes end
    resources :pillars do as_routes end
  end

  match 'login' => 'site#create'
  root to: "site#new"
end
