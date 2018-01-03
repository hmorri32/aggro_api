Rails.application.routes.draw do
  root to: 'api/v1/base#welcome'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get '/spots', to: "spots#index"
    end
  end
end
