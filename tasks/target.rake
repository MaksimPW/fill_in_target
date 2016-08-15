require './setup_capybara'
require 'pry'
namespace :target do
  desc 'Creates audence in website target.my.com'
  task :fill_in_target, [:login, :password, :audience_name, :box_player, :box_payer] do |t, args|
    puts 'Hello target!'

    b = Capybara.current_session
    b = login_in_target(b, args[:login], args[:password])

    b.visit "https://target.my.com/ads/audience/"
    b.has_css?('.js-create-audience-form-button')
    b.click_on 'Создать аудиторию...'

    b.has_css?('.audience-form')
    b.find(:css, 'input.js-audience-form-name').set((args[:audience_name]).to_s)
    b.find(:css, "#box--player").set(args[:box_player])
    b.find(:css, "#box--payer").set(args[:box_payer])

    b.has_css?('.audience-form__create-button')
    b.click_on 'Создать аудиторию'

    puts b.current_url
    binding.pry

  end
end

def login_in_target(b,login,password)
  url = "https://target.my.com/"
  b.visit url
  b.has_css?('.ph-button__text')
  link = b.all '.ph-button__text'
  link.first.click
  b.has_content?('Регистрация')
  b.fill_in 'login', with: login.to_s
  b.fill_in 'password', with: password.to_s
  b.click_on 'Войти'
  b
end