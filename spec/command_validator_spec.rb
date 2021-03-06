require 'spec_helper'
require_relative '../app/command_validator'

describe CommandValidator do
  subject         { CommandValidator.new }
  let(:error_msg) { 'You have to create a new M x N bitmap with "I M N" command' }

  describe '#validate_create_new_bitmap' do
    let(:error_msg1) { 'You should provide two dimensions, width and height.' }
    let(:error_msg2) { 'Dimensions are out of range. Dimensions should be between 1 and 250.' }
    let(:error_msg3) { 'Coordinates must be an integer.' }

    it { expect(subject.validate_create_new_bitmap('1', '5')).to eq([]) }

    it { expect(subject.validate_create_new_bitmap(nil, '5')).to eq([error_msg1]) }
    it { expect(subject.validate_create_new_bitmap('2', nil)).to eq([error_msg1]) }
    it { expect(subject.validate_create_new_bitmap(nil, nil)).to eq([error_msg1]) }

    it { expect(subject.validate_create_new_bitmap('0', '251')).to eq([error_msg2]) }
    it { expect(subject.validate_create_new_bitmap('5', '255')).to eq([error_msg2]) }
    it { expect(subject.validate_create_new_bitmap('-245', '0')).to eq([error_msg2]) }

    it { expect(subject.validate_create_new_bitmap('string', '0')).to eq([error_msg3]) }
  end

  describe '#validate_clear_bitmap' do
    let(:bitmap) { double(:bitmap, width: 3, height: 5) }

    it { expect(subject.validate_clear_bitmap(nil)).to eq([error_msg]) }
    it { expect(subject.validate_clear_bitmap(bitmap)).to eq([]) }
  end

  describe '#validate_colour_pixel' do
    let(:error_msg1) { 'Missing parameters. Correct command: "L X Y C"' }
    let(:error_msg2) { "Pixel coordinates should be within range; X: 1 - #{bitmap.width}, Y: 1 - #{bitmap.height}" }
    let(:error_msg3) { 'Colour should be specified as a capital letter.' }
    let(:error_msg4) { 'Coordinates must be an integer.' }
    let(:bitmap)     { double(:bitmap, width: 3, height: 5) }

    it { expect(subject.validate_colour_pixel(bitmap, '1', '5', 'C')).to eq([]) }

    it { expect(subject.validate_colour_pixel(nil, '-1', '5', nil)).to eq([error_msg]) }
    it { expect(subject.validate_colour_pixel(bitmap, '-1', '5', nil)).to eq([error_msg1]) }
    it { expect(subject.validate_colour_pixel(bitmap, '-1', nil, nil)).to eq([error_msg1]) }
    it { expect(subject.validate_colour_pixel(bitmap, '-1', '5', 'W')).to eq([error_msg2]) }
    it { expect(subject.validate_colour_pixel(bitmap, '3', '99', 'W')).to eq([error_msg2]) }
    it { expect(subject.validate_colour_pixel(bitmap, '3', '5', 'c')).to eq([error_msg3]) }
    it { expect(subject.validate_colour_pixel(bitmap, '2', 'string', 'W')).to eq([error_msg4]) }
  end

  describe '#validate_draw_vertical_line' do
    let(:error_msg1) { 'Missing parameters. Correct command: "V X Y1 Y2 C"' }
    let(:error_msg2) { "X coordinate should be in range: 1 - #{bitmap.width}" }
    let(:error_msg3) { "Y1 coordinate should be in range: 1 - #{bitmap.height}" }
    let(:error_msg4) { "Y2 coordinate should be in range: 1 - #{bitmap.height}" }
    let(:error_msg5) { 'coord Y2 should be greater than coord Y1.' }
    let(:error_msg6) { 'Colour should be specified as a capital letter.' }
    let(:error_msg7) { 'Coordinates must be an integer.' }
    let(:bitmap)     { double(:bitmap, width: 3, height: 11) }

    it { expect(subject.validate_draw_vertical_line(bitmap, '1', '1', '2', 'W')).to eq([]) }

    it { expect(subject.validate_draw_vertical_line(nil, '1', '1', '2', nil)).to eq([error_msg]) }
    it { expect(subject.validate_draw_vertical_line(bitmap, '1', '1', '2', nil)).to eq([error_msg1]) }
    it { expect(subject.validate_draw_vertical_line(bitmap, '123', '1', '2', nil)).to eq([error_msg1]) }
    it { expect(subject.validate_draw_vertical_line(bitmap, '123', '1', '2', 'W')).to eq([error_msg2]) }
    it { expect(subject.validate_draw_vertical_line(bitmap, '1', '0', '2', 'W')).to eq([error_msg3]) }
    it { expect(subject.validate_draw_vertical_line(bitmap, '1', '1', '99', 'W')).to eq([error_msg4]) }
    it { expect(subject.validate_draw_vertical_line(bitmap, '1', '3', '1', 'W')).to eq([error_msg5]) }
    it { expect(subject.validate_draw_vertical_line(bitmap, '1', '1', '3', 'c')).to eq([error_msg6]) }
    it { expect(subject.validate_draw_vertical_line(bitmap, '1', 'string', '3', 'W')).to eq([error_msg7]) }

    it { expect(subject.validate_draw_vertical_line(bitmap, '1', '3', '11', 'W')).not_to eq([error_msg5]) }
  end

  describe '#validate_draw_horizontal_line' do
    let(:error_msg1) { 'Missing parameters. Correct command: "H X1 X2 Y C"' }
    let(:error_msg2) { "Y coordinate should be in range: 1 - #{bitmap.height}" }
    let(:error_msg3) { "X1 coordinate should be in range: 1 - #{bitmap.width}" }
    let(:error_msg4) { "X2 coordinate should be in range: 1 - #{bitmap.width}" }
    let(:error_msg5) { 'coord X2 should be greater than coord X1.' }
    let(:error_msg6) { 'Colour should be specified as a capital letter.' }
    let(:error_msg7) { 'Coordinates must be an integer.' }
    let(:bitmap)     { double(:bitmap, width: 11, height: 5) }

    it { expect(subject.validate_draw_horizontal_line(bitmap, '1', '2', '2', 'W')).to eq([]) }

    it { expect(subject.validate_draw_horizontal_line(nil, '1', '1', '2', nil)).to eq([error_msg]) }
    it { expect(subject.validate_draw_horizontal_line(bitmap, '1', '1', '2', nil)).to eq([error_msg1]) }
    it { expect(subject.validate_draw_horizontal_line(bitmap, '123', '1', '2', nil)).to eq([error_msg1]) }
    it { expect(subject.validate_draw_horizontal_line(bitmap, '1', '2', '123', 'W')).to eq([error_msg2]) }
    it { expect(subject.validate_draw_horizontal_line(bitmap, '0', '1', '2', 'W')).to eq([error_msg3]) }
    it { expect(subject.validate_draw_horizontal_line(bitmap, '1', '15', '3', 'W')).to eq([error_msg4]) }
    it { expect(subject.validate_draw_horizontal_line(bitmap, '4', '2', '1', 'W')).to eq([error_msg5]) }
    it { expect(subject.validate_draw_horizontal_line(bitmap, '1', '2', '3', 's')).to eq([error_msg6]) }
    it { expect(subject.validate_draw_horizontal_line(bitmap, '1', 'string', '3', 'W')).to eq([error_msg7]) }

    it { expect(subject.validate_draw_horizontal_line(bitmap, '5', '10', '1', 'W')).not_to eq([error_msg5]) }
  end
end
