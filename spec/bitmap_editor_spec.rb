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
end
