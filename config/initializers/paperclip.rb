Paperclip.interpolates :id_sha1 do |attachment, style|
  Digest::SHA1.hexdigest(attachment.instance.id.to_s)[0..4]
end
