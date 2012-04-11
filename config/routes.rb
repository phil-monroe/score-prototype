ScoreProto::Application.routes.draw do
  
  match 'login' => 'site#create'
  root to: "site#new"
end
