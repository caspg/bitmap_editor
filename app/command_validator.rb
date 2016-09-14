class CommandValidator
  MIN_DIMENSION = 1
  MAX_DIMENSION = 250

  attr_reader :errors

  def initialize(bitmap = nil)
    @errors = []
  end

  def validate_create_new_bitmap(width, height)
    if width.nil? || height.nil?
      errors << 'You should provide two dimensions, width and height.'
    elsif !integer?(width) || !integer?(height)
      errors << 'Coordinates must be an integer.'
    elsif !dimensions_in_range?(width, height)
      errors << 'Dimensions are out of range. Dimensions should be between 1 and 250.'
    end

    errors
  end

  def validate_clear_bitmap(bitmap)
    bitmap.nil? ? [create_new_bitmap_msg] : []
  end

  def validate_colour_pixel(bitmap, x, y, colour)
    return [create_new_bitmap_msg] if bitmap.nil?
    return ['Missing parameters. Correct command: "L X Y C"'] if x.nil? || y.nil? || colour.nil?
    return ['Coordinates must be an integer.'] unless integer?(x) && integer?(y)

    unless pixel_coords_in_range?(bitmap, x, y)
      errors << "Pixel coordinates should be within range; X: #{MIN_DIMENSION} - #{bitmap.width}, Y: #{MIN_DIMENSION} - #{bitmap.height}"
    end

    errors << incorrect_colour_msg unless correct_colour?(colour)
    errors
  end

  def validate_draw_vertical_line(bitmap, x, y1, y2, colour)
    return [create_new_bitmap_msg] if bitmap.nil?

    if x.nil? || y1.nil? || y2.nil? || colour.nil?
      return ['Missing parameters. Correct command: "V X Y1 Y2 C"']
    end

    unless integer?(x) && integer?(y1) && integer?(y2)
      return ['Coordinates must be an integer.']
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

    errors << incorrect_colour_msg unless correct_colour?(colour)
    errors
  end

  def validate_draw_horizontal_line(bitmap, x1, x2, y, colour)
    return [create_new_bitmap_msg] if bitmap.nil?

    if x1.nil? || x2.nil? || y.nil? || colour.nil?
      return ['Missing parameters. Correct command: "H X1 X2 Y C"']
    end

    unless integer?(x1) && integer?(x2) && integer?(y)
      return ['Coordinates must be an integer.']
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

    errors << incorrect_colour_msg unless correct_colour?(colour)
    errors
  end

  private

  def create_new_bitmap_msg
    'You have to create a new M x N bitmap with "I M N" command'
  end

  def incorrect_colour_msg
    'Colour should be specified as a capital letter.'
  end

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
    coord1.to_i < coord2.to_i
  end

  def integer?(variable)
    variable.to_i.to_s == variable
  end

  def correct_colour?(colour)
    colour.length == 1 && colour.match(/[A-Z]/)
  end
end
