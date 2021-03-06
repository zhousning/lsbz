class Enclosure < ActiveRecord::Base
  mount_uploader :file, EnclosureUploader

  belongs_to :notice
  belongs_to :article
  belongs_to :website
  belongs_to :page
  belongs_to :block_content
  belongs_to :format
  belongs_to :carousel
  belongs_to :ocr
  belongs_to :ctg_mtrl
  belongs_to :prst_form
  belongs_to :aprv_form
  belongs_to :pay_form
  belongs_to :cstr_form
  belongs_to :cstr_form
  belongs_to :vst_form
end


# == Schema Information
#
# Table name: enclosures
#
#  id          :integer         not null, primary key
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  file        :string          default(""), not null
#  notice_id   :integer
#  article_id  :integer
#  page_id     :integer
#  format_id   :integer
#  ocr_id      :integer
#  ctg_mtrl_id :integer
#

