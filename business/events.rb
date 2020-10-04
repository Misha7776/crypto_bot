module Events
  CurrencyCreated = Class.new(RailsEventStore::Event)
  CurrencyUpdated = Class.new(RailsEventStore::Event)
  CurrencyDeleted = Class.new(RailsEventStore::Event)
end