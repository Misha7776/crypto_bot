# frozen_string_literal: true

module Commands
  class GetAll < Commands::Base
    def call
      { text: I18n.t('get_all_text'),
        reply_markup: get_all_keyboard_markup }
    end
  end
end
