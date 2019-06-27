class UserMailer < ActionMailer::Base
  default from: "chicago.lead.mentor@devbootcamp.com"
  add_template_helper(ApplicationHelper)

  def user_activation(user)
    @user = user

    @url = "http://mentoring.devbootcamp.com/activations/" + user.activation_code + "/user"

    mail(:to => user.email, :subject => "Please confirm that you're an actual person")
  end

  def appointment_request(availability, mentee)
    @availability = availability
    @mentor = availability.mentor
    @mentee = mentee

    @url = "http://mentoring.devbootcamp.com/appointments/" + @mentor.activation_code + "/create?mentee_id=#{@mentee.id}&availability_id=#{@availability.id}"

    mail(:to => @mentor.email, :subject => "#{@mentee.name} has requested to learn with you")
  end

  def appointment_confirmation(appointment)
    @appointment = appointment
    @mentor = appointment.mentor
    @mentee = appointment.mentee

    mail(:to => @mentee.email, :subject => "#{@mentor.name} has agreed to learn with you!")
  end

end
