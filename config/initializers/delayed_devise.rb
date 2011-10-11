module Devise
  module Models
    module Recoverable
      handle_asynchronously :send_reset_password_instructions
    end
  end
end
