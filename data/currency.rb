class Currency < ApplicationRecord
  serialize :ask, Array
  serialize :bid, Array
  serialize :trade, Array
  enum exchange_status: { 'working': 0, 'suspended': 1 }
end
