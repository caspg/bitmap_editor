class CommandValidator
  MIN_DIMENSION = 1
  MAX_DIMENSION = 250

  def validate_create_new_bitmap(width, height)
    errors = []

    if width.nil? || height.nil?
      errors << 'You should provide two dimensions, width and height.'
    elsif !dimensions_in_range?(width, height)
      errors << 'Dimensions are out of range. Dimensions should be between 1 and 250.'
    end

    errors
  end

  def validate_colour_pixel(bitmap, x, y, colour)
    errors = []

    if x.nil? || y.nil? || colour.nil?
      errors << 'Missing parameters. Correct command: "L X Y C"'
      return errors
    end

    unless pixel_coords_in_range?(bitmap, x, y)
      errors << "Pixel coordinates should be within range; X: 1-#{bitmap.width}, Y: 1-#{bitmap.height}"
    end

    errors << 'Colour should be a string.' if colour.to_i.to_s == colour
    errors
  end

  private

  def dimensions_in_range?(width, height)
    width.to_i.between?(MIN_DIMENSION, MAX_DIMENSION) &&
      height.to_i.between?(MIN_DIMENSION, MAX_DIMENSION)
  end

  def pixel_coords_in_range?(bitmap, x, y)
    x.to_i.between?(MIN_DIMENSION, bitmap.width) &&
      y.to_i.between?(MIN_DIMENSION, bitmap.height)
  end
end
