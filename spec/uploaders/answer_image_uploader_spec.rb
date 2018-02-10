require 'rails_helper'
require 'carrierwave/test/matchers'

describe AnswerImageUploader do
  include CarrierWave::Test::Matchers

  let(:answer) { create(:answer) }
  let(:uploader) { AnswerImageUploader.new(answer, :cover) }

  before do
    AnswerImageUploader.enable_processing = true
    File.open('public/uploads/interview/cover/59/China-interview-cover.jpeg') { |f| uploader.store!(f) }
  end

  after do
    AnswerImageUploader.enable_processing = false
    uploader.remove!
  end

  context "when a cover has been uploaded" do
    it "has the correct format" do
      expect(uploader).to be_format('jpeg')
    end

    it "preserves the original image size" do
      expect(uploader).to have_dimensions(1280, 930)
    end

    it "creates a thumb version to fit within 400 by 200 pixels" do
      expect(uploader.thumb).to be_no_larger_than(400, 200)
    end
  end
end
