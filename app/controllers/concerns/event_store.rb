module EventStore
  extend ActiveSupport::Concern

  def read_stream(stream_name)
    binding.pry
    Rails.configuration.event_store.read.backward.stream(stream_name).to_a
  end
end
