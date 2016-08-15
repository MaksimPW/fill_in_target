require './setup_capybara'
require 'pry'
namespace :target do
  desc 'Creates audience in website target.my.com'
  task :fill_in_target, [:login,
                         :password,
                         :audience_name,
                         :box_player,
                         :box_payer,
                         :all_conditions,
                         :expand] do |t, args|

    b = Capybara.current_session
    b = login_in_target(b, args[:login], args[:password])
    b = create_audience(b, args[:audience_name],
                           args[:box_player],
                           args[:box_payer],
                           args[:all_conditions],
                           args[:expand])

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

def create_audience(b,audience_name,box_player,box_payer,all_conditions,expand)
  b.visit "https://target.my.com/ads/audience/"
  b.has_css?('.js-create-audience-form-button')
  b.click_on 'Создать аудиторию...'

  b.has_css?('.audience-form')

  if all_conditions == true
    b.find(:css, '#-box-logical-oper-all').set(true)
    b.find(:css, '#-box-logical-oper-one').set(false)
  else
    b.find(:css, '#-box-logical-oper-all').set(false)
    b.find(:css, '#-box-logical-oper-one').set(true)
  end

  b.find(:css, ".audience-form__cross-device__box").set(expand)
  b.find(:css, 'input.js-audience-form-name').set(audience_name.to_s)
  b.find(:css, "#box--player").set(box_player)
  b.find(:css, "#box--payer").set(box_payer)

  b.has_css?('.audience-form__create-button')
  b.click_on 'Создать аудиторию'
  b
end