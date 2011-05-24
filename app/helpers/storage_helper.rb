module StorageHelper
  def ajax_uploader_script(id, action, options={})
    raw script = <<-EOS
    <script type="text/javascript">
      function createUploader(){
        var uploader = new qq.FileUploader({
          element: document.getElementById('#{ id }'),
          action: '#{ action }',
          debug: true,
          params: {
            authenticity_token: '#{ form_authenticity_token }'
          },
          onComplete: function(id, fileName, responseJSON) {
            location.reload();
          }
        });
      }
      window.onload = createUploader;
    </script>
    EOS
  end
end
