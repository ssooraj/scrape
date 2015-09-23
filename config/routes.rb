Rails.application.routes.draw do
  root to: 'home#index'
  post '/scrap' => 'home#scrap'
end
