# frozen_string_literal: true

class Appointment < ActiveRecord::Base
  attr_accessor :availability

  belongs_to :mentor, class_name: 'User'
  belongs_to :mentee, class_name: 'User'

  validates :mentor_id, presence: true
  validates :mentee, presence: true

  before_create :parse_availability
  after_create :kill_availability

  scope :visible, proc {
    where('start_time > ?', Time.now)
  }

  private

  def parse_availability
    self.start_time = availability.start_time
    self.end_time   = availability.end_time
    self.timezone   = availability.timezone
    self.location   = availability.location
  end

  def kill_availability
    availability.destroy
  end
end
