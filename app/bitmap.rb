class Bitmap
  attr_reader :width, :height, :pixels

  WHITE = 'O'.freeze

  def initialize(width:, height:)
    @width = width
    @height = height
    @pixels = create_pixels
  end

  private

  def create_pixels
    Array.new(height, Array.new(width, WHITE))
  end
end
