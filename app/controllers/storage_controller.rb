class StorageController < ApplicationController

  def upload
    begin
      _store_upload(params[:qqfile])
    rescue
      render :json => { :error => $!.message.to_s }
    else
      render :json => { :success => true }
    end
  end

  private
  def _store_upload(file)
    if request.xhr?
      if request.body.length == request.headers['CONTENT_LENGTH'].to_i
        file_data = request.body.read
        file_name = file
        file_size = request.body.length
      end
    else
      if file.instance_of?(File)
        file_data = file.read
        file_name = file.original_filename
      end
    end
    raise "upload failure" unless file_data

    tf = Tempfile.new(file_name)
    tf << file_data
    @storage                = Storage.new
    @storage.item           = tf
    @storage.item_file_name = file_name
    @storage.item_file_size = file_size if file_size
    @storage.save
  end


end
