class Storage < ActiveRecord::Base
  has_attached_file :item,
    :storage => :s3,
    :s3_credentials => {
      :access_key_id => Setting.amazon_s3.access_key_id,
      :secret_access_key => Setting.amazon_s3.secret_access_key,
    },
    :bucket => Setting.s3_bucket,
    :path => ":attachment/:id/:style.:extension",
    :bucket => 'mybucket'
end
