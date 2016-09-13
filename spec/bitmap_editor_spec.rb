require 'spec_helper'
require_relative '../app/bitmap_editor'

describe BitmapEditor do
  subject { described_class.new }

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
    before do
      # return different values each time :gets is called
      allow(subject).to receive(:gets).and_return(input, 'X')
    end

    context 'when command is I' do
      let(:input) { 'I' }
    end

    context 'when command is C' do
      let(:input) { 'C' }
    end

    context 'when command is L' do
      let(:input) { 'L' }
    end

    context 'when command is V' do
      let(:input) { 'V' }
    end

    context 'when command is H' do
      let(:input) { 'H' }
    end

    context 'when command is S' do
      let(:input) { 'S' }
    end

    context 'when command is ?' do
      let(:input) { '?' }

      it { expect { subject.run }.to output(expected_help_message_regex).to_stdout }
    end

    context 'when command is X' do
      let(:input) { 'X' }

      it { expect { subject.run }.to output(/goodbye!/).to_stdout }
    end

    context 'when there is no input' do
      let(:input) { '' }

      it { expect { subject.run }.to output(/type \? for help\n>/).to_stdout }
    end

    context 'when there is unrecognised command' do
      let(:input) { 'stranger things' }

      it { expect { subject.run }.to output(/unrecognised command \:\(/).to_stdout }
    end
  end

  def expected_help_message_regex
    /#{Regexp.quote(expected_help_message_string)}/
  end

  def expected_help_message_string
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
