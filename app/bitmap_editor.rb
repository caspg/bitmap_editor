class BitmapEditor
  def run
    @running = true
    show_initial_message

    while @running
      print '> '
      splitted_input = gets.chomp.split(' ')

      execute_command(splitted_input)
    end
  end

  def execute_command(splitted_input)
    case splitted_input[0]
    when 'I'
      puts 'command: I'
    when 'C'
      puts 'command: C'
    when 'L'
      puts 'command: L'
    when 'V'
      puts 'command: V'
    when 'H'
      puts 'command: H'
    when 'S'
      puts 'command: S'
    when '?'
      show_help
    when 'X'
      exit_console
    when nil
      show_initial_message
    else
      puts 'unrecognised command :('
    end
  end

  private

  def show_initial_message
    puts 'type ? for help'
  end

  def exit_console
    puts 'goodbye!'
    @running = false
  end

  def show_help
    puts help_message
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
