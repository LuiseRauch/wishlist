class UpdateMailer < ApplicationMailer
  default from: "hi@wunschlist.io"

  def daily_update(user, friends, active_wishes, active_public_lists)
    @user = user
    @friends = friends
    @active_wishes = active_wishes
    @active_public_lists = active_public_lists

    mail(to: user.email, subject: 'Wunschlist.io updates for #{user.username}')
  end
end
