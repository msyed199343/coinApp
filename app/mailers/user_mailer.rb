class UserMailer < ApplicationMailer
default from: 'coinapp@gmail.com'

    def welcome_with_api_token!(user)
        @user = user
        
        mail(
            to: @user.email, 
            subject: 'Welcome to CoinApp!'
            )
    end

    def coinsLow(coin)
        #set @coin to coin 
        @coin = coin
        #sql below to grab all admins then send mail to all admins array
        @admins = User.where(account_type: "admin").pluck(:email)

     
            mail(
                to: @admins.shift,
                bcc:@admins, 
                subject: "#{@coin.name} is low!"
                )
    end
     
end
