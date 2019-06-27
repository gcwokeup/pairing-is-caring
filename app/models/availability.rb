# frozen_string_literal: true

class Availability < ActiveRecord::Base
  attr_accessor :duration

  belongs_to :mentor, class_name: 'User'

  validates :start_time, presence: true

  before_save :adjust_for_timezone
  before_save :set_end_time

  scope :visible, proc {
    includes(:mentor)
        .where('start_time > ?', Time.now)
  }

  private

  def adjust_for_timezone
    self.start_time = ActiveSupport::TimeZone.find_tzinfo(timezone).local_to_utc(start_time)
  end

  def set_end_time
    self.end_time = start_time + duration.to_i * 60
  end
end
