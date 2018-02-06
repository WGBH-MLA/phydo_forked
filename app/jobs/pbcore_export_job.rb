require 'blacklight'
require 'zip'

class PbcoreExportJob < ActiveJob::Base
  queue_as :pbcore_export

  def perform(search_params, filename: 'pbcore_export.zip')
    # add .zip extension, regardless of whether it's already there or not.
    filename = filename.sub(/(\.zip)?$/, '.zip')
    raise "#{filename} already exists!" if File.exist? filename
    file_sets_from_search_params(search_params).each do |file_set|
      Zip::File.open(filename, Zip::File::CREATE) do |zipfile|
        # Use the basename of the filename without the .zip extension for the
        # name of the directory all the PBCore XML files will live under.
        zipped_dir_name = File.basename(filename).sub(/(\.zip)?$/, '')
        zipfile.get_output_stream(File.join(zipped_dir_name, filename_to_use_in_zip_archive(file_set))) do |f|
          f.write file_set.pbcore.content
        end
      end
    end
  end

  private

    def index_service
      @index_service ||= Blacklight.default_index
    end

    def file_sets_from_search_params(search_params)
      FileSet.where(id: ids_from_search_params(search_params))
    end

    def ids_from_search_params(search_params)
      index_service.search(q: search_params, rows: 99999999)['response']['docs'].map { |doc| doc['id'] }
    end

    def filename_to_use_in_zip_archive(file_set)
      "#{file_set.id}.pbcore.xml"
    end
end
