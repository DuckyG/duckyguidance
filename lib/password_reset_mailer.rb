class PasswordResetMailer < Devise::Mailer
  def reset_password_instructions(record)
    Delayed::Job.enqueue PasswordResetJob.new(record.id)
  end
end
