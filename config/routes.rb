Rails.application.routes.draw do
  use_doorkeeper_openid_connect
  use_doorkeeper
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
