# == Schema Information
# Schema version: 20110607050222
#
# Table name: phcs
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Phc < ActiveRecord::Base
  has_many :users
  has_many :patients
  has_many :anms

  validates :name, :presence => true

  def patients_due_today
    patients.select(&:appointment_today?)
  end
end
