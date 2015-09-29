Rails.application.routes.draw do
  root to: 'home#index'
  match '/scrap' => 'home#scrap'
  match 'image' => 'home#image'
  match '/scrapper' => 'home#scrapper'
end
