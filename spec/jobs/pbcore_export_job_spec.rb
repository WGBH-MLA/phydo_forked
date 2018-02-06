require 'rails_helper'
require 'fixtures'
require 'equivalent-xml'

RSpec.describe PbcoreExportJob do
  # TODO: Need to test much larger numbers, but it's expensive to do so.
  let(:number_of_pbcore_files) { 5 }
  let(:search_title) { "example file set for export" }
  let(:search_params) { { title: search_title } }
  let(:pbcore_export_filename) { "#{Dir.mktmpdir}/pbcore_export.zip" }

  before do
    number_of_pbcore_files.times do
      create(:file_set, title: [search_title], pbcore: Fixtures.open('pbcore/pbcore_2_0.xml'))
    end
  end

  describe 'after running PBCore export job', :clean_fedora do
    before do
      File.delete pbcore_export_filename if File.exist? pbcore_export_filename
      PbcoreExportJob.perform_now(search_params, filename: pbcore_export_filename)
    end

    it 'generates the export file at the specified location' do
      expect(File.exist?(pbcore_export_filename)).to eq true
    end

    # TODO: this is an expensive test
    it 'exports a zip file containing all the PBCore' do
      Zip::File.open(pbcore_export_filename) do |zip_file|
        zip_file.each do |entry|
          expect(entry.get_input_stream.read).to be_equivalent_to Fixtures.read('pbcore/pbcore_2_0.xml')
        end
      end
    end
  end
end
