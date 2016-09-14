require 'spec_helper'
require_relative '../app/command_validator'

describe CommandValidator do
  subject { CommandValidator.new }

  describe '#validate_create_new_bitmap' do
    error_message1 = 'You should provide two dimensions, width and height.'
    error_message2 = 'Dimensions are out of range. Dimensions should be between 1 and 250.'

    it { expect(subject.validate_create_new_bitmap(nil, 5)).to eq([error_message1]) }
    it { expect(subject.validate_create_new_bitmap(2, nil)).to eq([error_message1]) }
    it { expect(subject.validate_create_new_bitmap(nil, nil)).to eq([error_message1]) }

    it { expect(subject.validate_create_new_bitmap(0, 251)).to eq([error_message2]) }
    it { expect(subject.validate_create_new_bitmap(5, 255)).to eq([error_message2]) }
    it { expect(subject.validate_create_new_bitmap(-245, 0)).to eq([error_message2]) }
  end
end
