require 'spec_helper'
require_relative '../app/command_validator'

describe CommandValidator do
  subject { CommandValidator.new }

  describe '#validate_create_new_bitmap' do
    let(:error_message1) { 'You should provide two dimensions, width and height.' }
    let(:error_message2) { 'Dimensions are out of range. Dimensions should be between 1 and 250.' }

    it { expect(subject.validate_create_new_bitmap(nil, 5)).to eq([error_message1]) }
    it { expect(subject.validate_create_new_bitmap(2, nil)).to eq([error_message1]) }
    it { expect(subject.validate_create_new_bitmap(nil, nil)).to eq([error_message1]) }

    it { expect(subject.validate_create_new_bitmap(0, 251)).to eq([error_message2]) }
    it { expect(subject.validate_create_new_bitmap(5, 255)).to eq([error_message2]) }
    it { expect(subject.validate_create_new_bitmap(-245, 0)).to eq([error_message2]) }
  end

  describe '#validate_colour_pixel' do
    let(:error_message1) { 'Missing parameters. Correct command: "L X Y C"' }
    let(:error_message2) { "Pixel coordinates should be within range; X: 1-#{bitmap.width}, Y: 1-#{bitmap.height}" }
    let(:error_message3) { 'Colour should be a string.' }
    let(:bitmap)         { double(:bitmap, width: 3, height: 5) }

    it { expect(subject.validate_colour_pixel(bitmap, -1, 5, nil)).to eq([error_message1]) }
    it { expect(subject.validate_colour_pixel(bitmap, -1, nil, nil)).to eq([error_message1]) }

    it { expect(subject.validate_colour_pixel(bitmap, -1, 5, 'W')).to eq([error_message2]) }
    it { expect(subject.validate_colour_pixel(bitmap, 3, 99, 'W')).to eq([error_message2]) }

    it { expect(subject.validate_colour_pixel(bitmap, 3, 5, '66')).to eq([error_message3]) }
  end
end
