Wordbot::Application.routes.draw do
  root to: 'games#index'

  get "games" => 'games#index', as: 'games'

  get "game/:level" => 'games#show', as: 'game'

  post 'games/evaluate' => 'games#evaluate', as: 'eval'
end
