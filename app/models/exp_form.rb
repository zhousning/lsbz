class ExpForm < ActiveRecord::Base
  dragonfly_accessor :qr_code

  include AASM

  aasm :column => 'state' do
    state :opening, initial: true
    state :prospecting, :pending, :paying, :constructing, :visiting, :completed

    event :prospect do
      transitions from: :opening, to: :prospecting
    end

    event :pend do
      transitions from: :prospecting, to: :pending
    end

    event :pay do
      transitions from: :pending, to: :paying
    end

    event :construct do
      transitions from: :paying, to: :constructing
    end

    event :visit do
      transitions from: :constructing, to: :visiting
    end

    event :complete do
      transitions from: :visiting, to: :completed
    end
  end




  has_one :prst_form, :dependent => :destroy
  has_one :aprv_form, :dependent => :destroy
  has_one :pay_form, :dependent => :destroy
  has_one :cstr_form, :dependent => :destroy
  has_one :vst_form, :dependent => :destroy

  has_many :attachments, :dependent => :destroy
  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true


end
