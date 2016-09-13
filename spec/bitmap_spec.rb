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
      expected_bitmap_pixels = [['O', 'O'], ['O', 'O'], ['O', 'O']]

      expect(bitmap.pixels).to eq(expected_bitmap_pixels)
    end
  end
end
