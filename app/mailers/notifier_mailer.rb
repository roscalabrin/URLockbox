class NotifierMailer < ApplicationMailer
  def link_notify(link, email)
    @link = link
    mail(:to => email, :subject => "Link Added to URLockbox")
  end
end
