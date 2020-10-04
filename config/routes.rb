require 'sidekiq/web'

Rails.application.routes.draw do
 mount Sidekiq::Web => '/sidekiq'
 telegram_webhook Telegram::WebhookController

 get '/*a', to: 'application#not_found'
end
