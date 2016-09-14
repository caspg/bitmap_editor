require 'spec_helper'
require_relative '../app/bitmap'

describe Bitmap do
  describe 'creating new object' do
    it 'raises an error when :width or :height is not given' do
      error_message = 'missing keywords: width, height'
      expect { described_class.new }.to raise_error(ArgumentError, error_message)
    end

    it 'creates 2-dimension array with given size and default colour' do
      bitmap = Bitmap.new(width: 2, height: 3)
      expected_bitmap_pixels = [['O', 'O', 'O'], ['O', 'O', 'O']]

      expect(bitmap.pixels).to eq(expected_bitmap_pixels)
    end

    describe '#colour_pixel' do
      it 'colours the (X, Y) pixel with given colour' do
        bitmap = Bitmap.new(width: 3, height: 4)
        new_colour = 'A'
        bitmap.colour_pixel(1, 2, new_colour)

        expect(bitmap.pixels[1 - 1][2 - 1]).to eq(new_colour)
      end
    end

    describe '#clear_pixels' do
      it 'sets all pixels to white' do
        bitmap = Bitmap.new(width: 2, height: 3)
        bitmap.colour_pixel(1, 2, 'B')
        bitmap.colour_pixel(0, 1, 'B')
        bitmap.clear_pixels
        expected_bitmap_pixels = [['O', 'O', 'O'], ['O', 'O', 'O']]

        expect(bitmap.pixels).to eq(expected_bitmap_pixels)
      end
    end

    describe '#draw_vertical_line' do
      it 'sets all pixels in vertical line to given colour' do
        bitmap = Bitmap.new(width: 2, height: 3)
        bitmap.draw_vertical_line(0, 2, 3, 'C')
        expected_bitmap_pixels = [['O', 'O', 'O'], ['O', 'C', 'C']]

        expect(bitmap.pixels).to eq(expected_bitmap_pixels)
      end
    end

    describe '#draw_vertical_line' do
      it 'sets all pixels in vertical line to given colour' do
        bitmap = Bitmap.new(width: 2, height: 3)
        bitmap.draw_horizontal_line(1, 2, 3, 'C')
        expected_bitmap_pixels = [['O', 'O', 'C'], ['O', 'O', 'C']]

        expect(bitmap.pixels).to eq(expected_bitmap_pixels)
      end
    end
  end
end
