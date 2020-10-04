# frozen_string_literal: true

module Commands
  class UpdateCurrency < Commands::Base
    include Telegram::Bot::UpdatesController::Session
    PARAMS = %i[id name symbol bid ask].freeze

    def call
      prepare_session
      find_currency if webhook.payload['data'].present?
      return select_currency if currency.blank? && webhook.session[:currency][:id].blank?

      assign_params
      update_currency if all_set?
      response_message
    end

    private

    attr_reader :currency, :response_message

    def select_currency
      { text: I18n.t('what_to_update'),
        reply_markup: get_all_keyboard_markup('update_currency') }
    end

    def set_id
      webhook.session[:currency][:id] = currency&.id
    end

    def prepare_session
      webhook.session[:currency] ||= Hash[PARAMS.map { |e| [e, nil] }]
    end

    def assign_params
      set_id if webhook.session[:currency][:id].blank?
      webhook.session[:currency].each do |param, value|
        next if value.present?

        webhook.save_next_step :update_currency!
        if webhook.payload['text'].blank?
          @response_message = { text: I18n.t("enter_update_#{param}") }
          break
        end
        webhook.session[:currency][param] = parse_input(param)
        webhook.payload['text'] = nil
      end
    end

    def update_currency
      response = Requests::UpdateCurrency.call(params: webhook.session)
      reset_session
      @response_message = if response.success?
                            { text: I18n.t('currency_updated'), reply_markup: start_keyboard_markup }
                          else
                            { text: response['errors'] }
                          end
    end
  end
end
