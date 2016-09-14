require 'spec_helper'
require_relative '../app/response'

describe Response do
  subject { described_class.new(bitmap, message) }

  describe 'initializing' do
    let(:bitmap)  { 'bitmap' }
    let(:message) { 'message' }

    it { expect(subject.bitmap).to eq(bitmap) }
    it { expect(subject.message).to eq(message) }
  end
end
