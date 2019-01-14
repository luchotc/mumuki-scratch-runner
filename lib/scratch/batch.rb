class Scratch::Batch
  attr_accessor :content

  def initialize(content)
    @content = content[:runtime]
  end
end