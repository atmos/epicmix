# All outgoing email comes from here
class ApplicationMailer < ActionMailer::Base
  default from: "epicmix+noreply@atmos.org"
  layout "mailer"
end
