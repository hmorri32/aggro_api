Rails.application.routes.draw do
  root to: 'api/v1/base#welcome'
  resources :users, only: :create do
    collection do
      post 'login'
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      namespace :spitcast do
        get '/daily/tides',         to: 'forecast#daily_sd_tides'
        get '/weekly/tides',        to: 'forecast#weekly_sd_tides'
        get '/daily/:spitcast_id',  to: 'forecast#daily_forecast'
        get '/weekly/:spitcast_id', to: 'forecast#weekly_forecast'
      end

      namespace :msw do
        get '/weekly/:msw_id', to: 'forecast#weekly_forecast'
      end

      namespace :surfline do
        get '/tides/:surfline_id',         to: 'forecast#tides'
        get '/weekly/:surfline_id',        to: 'forecast#weekly_forecast'
        get '/weekly/:surfline_id/parsed', to: 'forecast#weekly_parsed'
        get '/daily/:surfline_id',         to: 'forecast#daily_forecast'
        get '/daily/:surfline_id/parsed',  to: 'forecast#daily_parsed'
      end

      namespace :amalgamate do
        get 'weekly_forecast/:name', to: "forecast#weekly_forecast"
      end

      get '/spots', to: "spots#index"
      get '/spots_with_forecast', to: "spots#spots_with_forecast"
    end
  end
end
