class PasswordResetJob < Struct.new(:id)
  def perform
    counselor = Counselor.find(id)
    ActionMailer::Base.default_url_options[:host] = "https://#{counselor.school.subdomain.name}.duckyg.com"
    Devise::Mailer.reset_password_instructions(counselor).deliver
  end
end
