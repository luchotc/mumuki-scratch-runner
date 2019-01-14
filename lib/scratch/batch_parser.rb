module Scratch::BatchParser
  class << self
    def parse(request)
      Scratch::Batch.new request.content.parse_as_json
    end
  end
end
