require 'rails_helper'
require 'carrierwave/test/matchers'

describe CoverUploader do
  include CarrierWave::Test::Matchers

  let(:interview) { create(:interview) }
  let(:uploader) { CoverUploader.new(interview, :cover) }

  before do
    CoverUploader.enable_processing = true
    File.open("spec/images/test_image.jpeg") { |f| uploader.store!(f) }
  end

  after do
    CoverUploader.enable_processing = false
    uploader.remove!
  end

  context "when a cover has been uploaded" do
    it "has the correct format" do
      expect(uploader).to be_format('jpeg')
    end

    it "preserves the original image size" do
      expect(uploader).to have_dimensions(1280, 930)
    end
  end
end
