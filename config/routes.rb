ScoreProto::Application.routes.draw do
  resources :candidates
  resources :recruiters
  
  match 'login' => 'site#create'
  root to: "site#new"
end
