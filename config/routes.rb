Rails.application.routes.draw do
  match '/about', to: 'welcome#about', via: [:get, :post]
  match '/contact', to: 'welcome#contact', via: [:get, :post]
  match '/criteria', to: 'welcome#criteria', via: [:get, :post]
  match '/home', to: 'welcome#home', via: [:get, :post]
  match '/ranking', to: 'welcome#ranking', via: [:get, :post]
  match '/tutorial', to: 'welcome#tutorial', via: [:get, :post]
  match '/check', to: 'welcome#caller', via: [:get, :post]
  match '/getuniname', to: 'welcome#get_uni_name', via: [:get, :post]
  
  root 'welcome#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
