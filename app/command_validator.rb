class CommandValidator
  MIN_DIMENSION = 1
  MAX_DIMENSION = 250

  def validate_create_new_bitmap(width, height)
    errors = []

    if width.nil? || height.nil?
      errors << 'You should provide two dimensions, width and height.'
    elsif !integer?(width) || !integer?(height)
      errors << 'Coordinates must be an integer.'
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

    unless integer?(x) && integer?(y)
      errors << 'Coordinates must be an integer.'
      return errors
    end

    unless pixel_coords_in_range?(bitmap, x, y)
      errors << "Pixel coordinates should be within range; X: #{MIN_DIMENSION} - #{bitmap.width}, Y: #{MIN_DIMENSION} - #{bitmap.height}"
    end

    errors << 'Colour should be a string.' if colour.to_i.to_s == colour
    errors
  end

  def validate_draw_vertical_line(bitmap, x, y1, y2, colour)
    errors = []

    if x.nil? || y1.nil? || y2.nil? || colour.nil?
      errors << 'Missing parameters. Correct command: "V X Y1 Y2 C"'
      return errors
    end

    unless integer?(x) && integer?(y1) && integer?(y2)
      errors << 'Coordinates must be an integer.'
      return errors
    end

    unless x_coord_in_range?(bitmap.width, x)
      errors << "X coordinate should be in range: #{MIN_DIMENSION} - #{bitmap.width}"
    end

    if coords_in_correct_range?(y1, y2)
      msg = "coordinate should be in range: #{MIN_DIMENSION} - #{bitmap.height}"
      errors << "Y1 #{msg}" unless y_coord_in_range?(bitmap.height, y1)
      errors << "Y2 #{msg}" unless y_coord_in_range?(bitmap.height, y2)
    else
      errors << 'coord Y2 should be greater than coord Y1.'
    end

    errors << 'Colour should be a string.' if integer?(colour)
    errors
  end

  def validate_draw_horizontal_line(bitmap, x1, x2, y, colour)
    errors = []

    if x1.nil? || x2.nil? || y.nil? || colour.nil?
      errors << 'Missing parameters. Correct command: "H X1 X2 Y C"'
      return errors
    end

    unless integer?(x1) && integer?(x2) && integer?(y)
      errors << 'Coordinates must be an integer.'
      return errors
    end

    if coords_in_correct_range?(x1, x2)
      msg = "coordinate should be in range: #{MIN_DIMENSION} - #{bitmap.width}"
      errors << "X1 #{msg}" unless x_coord_in_range?(bitmap.width, x1)
      errors << "X2 #{msg}" unless x_coord_in_range?(bitmap.width, x2)
    else
      errors << 'coord X2 should be greater than coord X1.'
    end

    unless y_coord_in_range?(bitmap.height, y)
      errors << "Y coordinate should be in range: #{MIN_DIMENSION} - #{bitmap.height}"
    end

    errors << 'Colour should be a string.' if integer?(colour)
    errors
  end

  private

  def dimensions_in_range?(width, height)
    width.to_i.between?(MIN_DIMENSION, MAX_DIMENSION) &&
      height.to_i.between?(MIN_DIMENSION, MAX_DIMENSION)
  end

  def pixel_coords_in_range?(bitmap, x, y)
    x_coord_in_range?(bitmap.width, x) && y_coord_in_range?(bitmap.height, y)
  end

  def x_coord_in_range?(width, x)
    x.to_i.between?(MIN_DIMENSION, width)
  end

  def y_coord_in_range?(height, y)
    y.to_i.between?(MIN_DIMENSION, height)
  end

  def coords_in_correct_range?(coord1, coord2)
    coord1 < coord2
  end

  def integer?(variable)
    variable.to_i.to_s == variable
  end
end
