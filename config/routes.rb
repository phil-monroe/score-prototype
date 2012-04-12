ScoreProto::Application.routes.draw do
  resources :candidates do
    resources :raw_score_histories
  end
  resources :recruiters
	resources :available_events
  resources :events

  namespace :admin do
    resources :available_events do as_routes end
    resources :pillars do as_routes end
  end

  match 'login' => 'site#create'
  root to: "site#new"
end
