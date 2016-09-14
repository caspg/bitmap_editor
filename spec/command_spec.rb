require 'spec_helper'
require_relative '../app/command'

describe Command do
  subject { described_class.new }
  let(:validator) { double(:validator) }

  before do
    allow(CommandValidator).to receive(:new) { validator }
    allow(validator).to receive(:validate_create_new_bitmap) { errors }
    allow(validator).to receive(:validate_colour_pixel) { errors }
  end

  describe '#create_new_bitmap' do
    context 'when validator returns error' do
      let(:errors) { ['some error'] }

      it 'returns correct response object' do
        response = subject.create_new_bitmap(['I', nil, 2])

        expect(response).to be_instance_of(Response)
        expect(response.bitmap).to eq(nil)
        expect(response.message).not_to be_empty
      end
    end

    context 'when validator does not return error' do
      let(:errors) { [] }

      it 'returns correct response object' do
        response = subject.create_new_bitmap(['I', 1, 2])

        expect(response).to be_instance_of(Response)
        expect(response.bitmap).to be_instance_of(Bitmap)
        expect(response.message).to be_empty
      end
    end
  end

  describe '#clear_bitmap' do
    let(:bitmap) { double }
    before { allow(bitmap).to receive(:clear_pixels) }

    it 'calls :clear_pixels' do
      subject.clear_bitmap(bitmap)
      expect(bitmap).to have_received(:clear_pixels)
    end

    it { expect(subject.clear_bitmap(bitmap)).to be_instance_of(Response) }
  end

  describe '#colour_pixel' do
    let(:bitmap) { double }
    before { allow(bitmap).to receive(:colour_pixel) }

    context 'when validator returns error' do
      let(:errors) { ['some error'] }

      it 'does not call :colour_pixel' do
        response = subject.colour_pixel(bitmap, ['L', 0, 1, 'W'])

        expect(bitmap).not_to have_received(:colour_pixel)
        expect(response).to be_instance_of(Response)
      end
    end

    context 'when validator does not return error' do
      let(:errors) { [] }

      it 'does not call :colour_pixel' do
        response = subject.colour_pixel(bitmap, ['L', 1, 1, 'W'])

        expect(bitmap).to have_received(:colour_pixel).with(1, 1, 'W')
        expect(response).to be_instance_of(Response)
      end
    end
  end

  describe '#show_bitmap' do
    let(:bitmap) { Bitmap.new(width: 3, height: 2) }

    it { expect(subject.show_bitmap(bitmap)).to be_instance_of(Response) }
    it { expect { subject.show_bitmap(bitmap) }.to output("O O O\nO O O\n").to_stdout }
  end
end
