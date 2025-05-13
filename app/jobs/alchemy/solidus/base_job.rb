module Alchemy
  module Solidus
    class BaseJob < ActiveJob::Base
      retry_on ActiveRecord::Deadlocked
    end
  end
end
