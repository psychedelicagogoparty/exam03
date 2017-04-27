class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_copygram.subject
  #
  def sendmail_copygram
    @greeting = "Hi"

    mail to: "september_girl_friend@yahoo.co.jp",
         subject:"[copygram] 写真が投稿されました"
  end
end
