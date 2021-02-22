Rails.application.routes.draw do
  get 'new', to: 'games#new'
  post 'score', to: 'game#score'
end

