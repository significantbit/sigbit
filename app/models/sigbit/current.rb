module Sigbit
  class Current < ActiveSupport::CurrentAttributes
    attribute :user
    attribute :request
  end
end
