# == Schema Information
# Schema version: 20110614044818
#
# Table name: appointments
#
#  id                  :integer         not null, primary key
#  patient_id          :integer
#  date                :date
#  created_at          :datetime
#  updated_at          :datetime
#  appointment_type_id :integer
#

class Appointment < ActiveRecord::Base
  attr_accessible :date, :appointment_type_id

  belongs_to :patient
  belongs_to :appointment_type, :primary_key => :appointment_type_id
  has_many :sms

  default_scope :order => "date ASC"

  validates :patient_id, :presence => true
  validates :appointment_type, :presence => true
  validates :date, :presence => true

  def name
    appointment_type.name
  end

  def message
    appointment_type.message.gsub(/%date%/, date).gsub(/%delivery_place%/, patient.delivery_place || "Undefined")
  end

  def date
    d = read_attribute(:date)
    d && d.strftime("%m-%d-%Y")
  end

  def info
    "#{name} on #{date}"
  end

  def sms_message
    "+#{name}+     #{message}"
  end
end
