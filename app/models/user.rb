# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  has_many :availabilities, foreign_key: :mentor_id
  has_many :mentoring_appointments, foreign_key: :mentor_id, class_name: 'Appointment'
  has_many :menteeing_appointments, foreign_key: :mentee_id, class_name: 'Appointment'

  validates_uniqueness_of :email


  # rubocop:disable AbcSize
  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_create do |user|
      user.email = auth.info.email
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.extra.raw_info.short_name
      user.avatar_url = auth.info.image + '?type=large' # assuming the user model has a name
    end
  end
  # rubocop:enable AbcSize

  def self.featured_mentors
    Appointment.limit(25).map(&:mentor).uniq.sort_by(&:name)
  end

  def name
    [first_name, last_name].compact.join(' ')
  end

  def send_activation
    UserMailer.user_activation(self).deliver
    self
  end

  def send_appointment_request(availability)
    UserMailer.appointment_request(availability, self).deliver
  end

  def send_appointment_confirmation(appointment)
    UserMailer.appointment_confirmation(appointment).deliver
  end
end
