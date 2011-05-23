Paperclip::Attachment.interpolations[:id_sha1] = proc do |attachment, style|
  Digest::SHA1.hexdigest(attachment.instance.id.to_s)
end
