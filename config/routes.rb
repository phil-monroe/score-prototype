ScoreProto::Application.routes.draw do
  resources :candidates do
    resources :raw_score_histories
  end
  resources :recruiters
	resources :available_events
  resources :events

  match 'login' => 'site#create'
  root to: "site#new"
end
