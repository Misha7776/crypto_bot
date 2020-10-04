# frozen_string_literal: true

module Telegram
  class WebhookController < Telegram::Bot::UpdatesController
    include Telegram::Bot::UpdatesController::MessageContext
    include Telegram::Bot::UpdatesController::Session
    after_action :call_back_answer, only: :callback_query
    use_session!

    def message(_message); end

    def start!(*)
      respond_with :message, ::Commands::Start.call(webhook: self)
    end

    def help!(*)
      respond_with :message, ::Commands::Help.call(webhook: self)
    end

    def get_all!(*)
      respond_with :message, ::Commands::GetAll.call(webhook: self)
    end

    def about!(*)
      respond_with :message, ::Commands::About.call(webhook: self)
    end

    def create_currency!(*)
      respond_with :message, ::Commands::CreateCurrency.call(webhook: self)
    end

    def update_currency!(*)
      respond_with :message, ::Commands::UpdateCurrency.call(webhook: self)
    end

    def delete_currency!(*)
      respond_with :message, ::Commands::DeleteCurrency.call(webhook: self)
    end

    def callback_query(data)
      respond_with :message, "::Commands::#{data.split('/')[1].classify}".constantize.call(webhook: self)
    rescue NameError => _e
      answer_callback_query I18n.t('error')
    end

    def inline_query(query, offset); end

    def chosen_inline_result(result_id, query); end

    def save_next_step(next_step)
      save_context next_step
    end

    private

    def call_back_answer
      answer_callback_query(nil)
    end
  end
end
