class Attachment < ActiveRecord::Base
  mount_uploader :file, AttachmentUploader
  belongs_to :exp_form
  belongs_to :prst_form
  belongs_to :aprv_form
  belongs_to :pay_form
  belongs_to :cstr_form
  belongs_to :cstr_form
  belongs_to :vst_form
end



# == Schema Information
#
# Table name: attachments
#
#  id         :integer         not null, primary key
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  file       :string          default(""), not null
#

