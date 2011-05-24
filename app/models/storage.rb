class Storage < ActiveRecord::Base
  has_attached_file :item,
    :storage => :s3,
    :s3_credentials => {
      :access_key_id      => Setting.amazon_s3.access_key_id,
      :secret_access_key  => Setting.amazon_s3.secret_access_key,
    },
    :bucket => "microblog-mio",
    :url    => ":id_sha1.:extension",
    :path   => ":id_sha1.:extension"

  def url
    self.item.url.gsub(/\?.*/, "")
  end
end
