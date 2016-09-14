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

  private

  def dimensions_in_range?(width, height)
    width.to_i.between?(MIN_DIMENSION, MAX_DIMENSION) &&
      height.to_i.between?(MIN_DIMENSION, MAX_DIMENSION)
  end
end
