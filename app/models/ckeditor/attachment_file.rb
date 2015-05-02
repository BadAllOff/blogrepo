class Ckeditor::AttachmentFile < Ckeditor::Asset
  has_attached_file :data,
                    default_url: '/images/:style/missing.png',
                    storage: :s3,
                    s3_credentials: "#{Rails.root}/config/s3.yml",
                    s3_protocol: 'https',
                    s3_host_name: 's3-eu-west-1.amazonaws.com',
                    :url => "/ckeditor/attachments/:id/:filename",
                    path: "ckeditor/attachments/:id/:filename"

  validates_attachment_presence :data
  validates_attachment_size :data, :less_than => 10.megabytes
  do_not_validate_attachment_file_type :data

  def url_thumb
    @url_thumb ||= Ckeditor::Utils.filethumb(filename)
  end
end