Rails.application.routes.draw do
  root to: 'api/v1/base#welcome'

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
        get '/weekly/:surfline_id',       to: 'forecast#weekly_forecast'
        get '/daily/:surfline_id',        to: 'forecast#daily_forecast'
        get '/daily/:surfline_id/parsed', to: 'forecast#parsed'
      end

      get '/spots', to: "spots#index"
    end
  end
end
