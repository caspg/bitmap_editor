require_relative './command_validator'
require_relative './response'
require_relative './bitmap'

class Command
  def create_new_bitmap(splitted_input)
    bitmap = nil
    width = splitted_input[1]
    height = splitted_input[2]
    errors = CommandValidator.new.validate_create_new_bitmap(width, height)

    bitmap = Bitmap.new(width: width, height: height) if errors.empty?

    Response.new(bitmap, errors)
  end

  def show_bitmap(bitmap)
    bitmap.pixels.transpose.each do |row|
      puts row.join(' ')
    end

    Response.new(bitmap, nil)
  end
end
