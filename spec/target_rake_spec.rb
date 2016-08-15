require 'rake'
require './setup_capybara'

describe 'target namespace rake task' do
  describe 'target:fill_in_target' do
    #TODO: You need write test login
    let(:login) { 'enter_login' }
    #TODO: You need write test password
    let(:password) { 'enter_password' }

    let(:audience_name) { 'test_audience_name' }
    let(:box_player) { true }
    let(:box_payer) { true }
    let(:all_conditions) { true }
    let(:expand) { true }

    before do
      load File.expand_path("./../../tasks/target.rake", __FILE__)
      Rake::Task.define_task(:environment)
    end

    it 'correct create name audience' do
      Rake::Task["target:fill_in_target"].invoke(login,
                                                 password,
                                                 audience_name,
                                                 box_player,
                                                 box_payer,
                                                 all_conditions,
                                                 expand)

      b = Capybara.current_session
      url = "https://target.my.com/"
      b.visit url
      b.has_css?('.ph-button__text')
      link = b.all '.ph-button__text'

      if link.first
        link.first.click
        b.has_content?('Регистрация')
        b.fill_in 'login', with: login.to_s
        b.fill_in 'password', with: password.to_s
        b.click_on 'Войти'
      end

      b.visit "https://target.my.com/ads/audience/"
      sleep 5
      expect(b).to have_content(audience_name)

      # Remove test audience
      b.find('.audience-list-item__name', :text => "#{audience_name}").click
      b.find('.js-audience-form-delete-button').click
      b.find('.js-audience-form-delete-yes').click
    end
  end
end