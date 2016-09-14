require_relative './response'
require_relative './command'

class BitmapEditor
  def initialize
    @bitmap = nil
  end

  def run
    @running = true
    puts initial_message

    while @running
      print '> '
      splitted_input = gets.chomp.split(' ')

      response = execute_command(splitted_input)
      @bitmap = response.bitmap
      puts response.message unless response.message.nil? || response.message.empty?
    end
  end

  def execute_command(splitted_input)
    case splitted_input[0]
    when 'I'
      Command.new.create_new_bitmap(splitted_input)
    # when 'C'
    #   puts 'command: C'
    # when 'L'
    #   puts 'command: L'
    # when 'V'
    #   puts 'command: V'
    # when 'H'
    #   puts 'command: H'
    when 'S'
      Command.new.show_bitmap(@bitmap)
    when '?'
      Response.new(@bitmap, help_message)
    when 'X'
      exit_console
    when nil
      Response.new(@bitmap, initial_message)
    else
      Response.new(@bitmap, 'unrecognised command :(')
    end
  end

  private

  def initial_message
    'type ? for help'
  end

  def exit_console
    @running = false
    Response.new(@bitmap, 'goodbye!')
  end

  def show_help
    Response.new(@bitmap, help_message)
  end

  def help_message
    <<~HEREDOC
      ? - Help
      I M N       - Create a new M x N image with all pixels coloured white (O).
      C           - Clears the table, setting all pixels to white (O).
      L X Y C     - Colours the pixel (X,Y) with colour C.
      V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
      H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
      S           - Show the contents of the current image
      X           - Terminate the session
    HEREDOC
  end
end
