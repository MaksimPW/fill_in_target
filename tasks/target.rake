require './setup_capybara'
require 'pry'
namespace :target do
  desc 'Creates audence in website target.my.com'
  task :fill_in_target, [:login, :password, :box_player, :box_payer] do |t, args|
    puts 'Hello target!'

    browser = Capybara.current_session
    browser = login_in_target(browser, args[:login], args[:password])

    browser.visit "https://target.my.com/ads/audience/"
    browser.has_css?('.js-create-audience-form-button')
    browser.click_on 'Создать аудиторию...'

    browser.has_css?('.audience-form')
    browser.find(:css, "#box--player").set(args[:box_player])
    browser.find(:css, "#box--payer").set(args[:box_payer])

    browser.has_css?('.audience-form__create-button')
    browser.click_on 'Создать аудиторию'

    puts browser.current_url
    binding.pry

  end
end

def login_in_target(browser,login,password)
  url = "https://target.my.com/"
  browser.visit url
  browser.has_css?('.ph-button__text')
  link = browser.all '.ph-button__text'
  link.first.click
  browser.has_content?('Регистрация')
  browser.fill_in 'login', with: login.to_s
  browser.fill_in 'password', with: password.to_s
  browser.click_on 'Войти'
  browser
end