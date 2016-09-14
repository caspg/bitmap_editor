class Response
  attr_reader :bitmap, :message

  def initialize(bitmap, message)
    @bitmap = bitmap
    @message = message
  end
end
