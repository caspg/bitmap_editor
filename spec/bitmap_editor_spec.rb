require 'spec_helper'
require_relative '../app/bitmap_editor'

describe BitmapEditor do
  subject      { described_class.new(bitmap) }
  let(:bitmap) { double(:bitmap) }

  describe '#run' do
    it 'outputs initial message with prompt sign' do
      allow(subject).to receive(:gets).and_return('X')

      expect { subject.run }.to output(/type \? for help\n>/).to_stdout
    end

    it 'calls #execute_command method with proper argument' do
      allow(subject).to receive(:gets).and_return('ARG1 ARG2 ARG3')
      allow(subject).to receive(:execute_command) { subject.send(:exit_console) }

      subject.run

      expect(subject).to have_received(:execute_command).with(%w(ARG1 ARG2 ARG3))
    end
  end

  describe '#execute_command' do
    let(:command)  { double(:command) }

    before do
      # return different values each time :gets is called
      # allow(subject).to receive(:gets).and_return(input, 'X')
      allow(Response).to receive(:new)
      allow(Command).to receive(:new).and_return(command)
      allow(command).to receive(:create_new_bitmap)
      allow(command).to receive(:clear_bitmap)
      allow(command).to receive(:colour_pixel)
      allow(command).to receive(:draw_vertical_line)
      allow(command).to receive(:draw_horizontal_line)
      allow(command).to receive(:show_bitmap)

      subject.execute_command(input)
    end

    context 'when command is I' do
      let(:input) { ['I', 2, 2] }

      it { expect(command).to have_received(:create_new_bitmap).with(input) }
    end

    context 'when command is C' do
      let(:input) { ['C'] }

      it { expect(command).to have_received(:clear_bitmap).with(bitmap) }
    end

    context 'when command is L' do
      let(:input) { ['L', 2, 3, 'A'] }

      it { expect(command).to have_received(:colour_pixel).with(bitmap, input) }
    end

    context 'when command is V' do
      let(:input) { ['V', 2, 3, 6, 'W'] }

      it { expect(command).to have_received(:draw_vertical_line).with(bitmap, input) }
    end

    context 'when command is H' do
      let(:input) { ['H', 3, 5, 2, 'Z'] }

      it { expect(command).to have_received(:draw_horizontal_line).with(bitmap, input) }
    end

    context 'when command is S' do
      let(:input) { ['S'] }

      it { expect(command).to have_received(:show_bitmap).with(bitmap) }
    end

    context 'when command is ?' do
      let(:input) { ['?'] }

      it { expect(Response).to have_received(:new).with(bitmap, expected_help_message) }
    end

    context 'when command is X' do
      let(:input) { 'X' }

      it { expect(Response).to have_received(:new).with(bitmap, 'goodbye!') }
    end

    context 'when there is no input' do
      let(:input) { '' }

      it { expect(Response).to have_received(:new).with(bitmap, "type \? for help") }
    end

    context 'when there is unrecognised command' do
      let(:input) { 'stranger things' }

      it { expect(Response).to have_received(:new).with(bitmap, 'unrecognised command :(') }
    end
  end

  def expected_help_message
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
