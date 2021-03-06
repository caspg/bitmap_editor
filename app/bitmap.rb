class Bitmap
  attr_reader :width, :height, :pixels

  WHITE = 'O'.freeze

  def initialize(width:, height:)
    @width = width.to_i
    @height = height.to_i
    @pixels = create_pixels
  end

  def colour_pixel(x, y, colour)
    x = x.to_i - 1
    y = y.to_i - 1

    @pixels[x][y] = colour
  end

  def clear_pixels
    @pixels.map! { |row| row.map! { WHITE } }
  end

  def draw_vertical_line(x, y1, y2, colour)
    x = x.to_i - 1
    y1 = y1.to_i - 1
    y2 = y2.to_i - 1

    (y1..y2).each do |row_index|
      @pixels[x][row_index] = colour
    end
  end

  def draw_horizontal_line(x1, x2, y, colour)
    x1 = x1.to_i - 1
    x2= x2.to_i - 1
    y = y.to_i - 1

    (x1..x2).each do |column_index|
      @pixels[column_index][y] = colour
    end
  end

  private

  def create_pixels
    Array.new(width) { Array.new(height, WHITE) }
  end
end
