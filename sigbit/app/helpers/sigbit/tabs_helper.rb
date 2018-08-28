module Sigbit
  module TabsHelper
    def tabs(*args, &block)
      Sigbit::TabsRenderer.new(self, *args, &block).render
    end
  end
end
