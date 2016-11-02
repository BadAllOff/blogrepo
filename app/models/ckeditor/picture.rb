# == Schema Information
#
# Table name: ckeditor_assets
#
#  id                :integer          not null, primary key
#  data_file_name    :string           not null
#  data_content_type :string
#  data_file_size    :integer
#  assetable_id      :integer
#  assetable_type    :string(30)
#  type              :string(30)
#  width             :integer
#  height            :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data, styles: { content: '800>', thumb: '118x100#' },
                    default_url: '/images/:style/missing.png',
                    # storage: :s3,
                    # s3_credentials: "#{Rails.root}/config/s3.yml",
                    # s3_protocol: 'https',
                    # s3_host_name: 's3-eu-west-1.amazonaws.com',
                    url: '/ckeditor/pictures/:id/:style_:basename.:extension',
                    path: 'ckeditor/pictures/:id/:style_:basename.:extension'


  validates_attachment_presence :data
  validates_attachment_size :data, less_than: 2.megabytes
  validates_attachment_content_type :data, content_type: /\Aimage/

  def url_content
    url(:content)
  end
end
