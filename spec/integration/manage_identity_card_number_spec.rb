require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.join(File.dirname(__FILE__),'..','..','..','..','..','spec','integration','alaveteli_dsl'))

describe 'Signing up' do

  it 'allows the user to specify their identity card number' do
    visit signup_path

    within '#signup' do
      fill_in 'Your e-mail', :with => 'test@localhost'
      fill_in 'Your name', :with => 'rspec'
      fill_in 'Password', :with => 'secret'
      fill_in 'Password: (again)', :with => 'secret'
      fill_in 'Identity Card Number', :with => '000-000000-0000Z'
      click_button 'Sign up'
    end

    visit confirm_url(:email_token => PostRedirect.last.email_token)
    visit show_user_profile_path(:url_name => 'rspec')

    expect(response).to contain('Hello, rspec!')
    expect(response).to contain('000-000000-0000Z')
  end

end

describe 'Managing identity card number' do

  before :each do
    @user = login(FactoryGirl.create(:user, :identity_card_number => '000-000000-0000Z'))
  end

  it 'allows the user to change their identity card number' do
    @user.visit user_edit_identity_card_number_path
    @user.fill_in 'New Identity Card Number:', :with => '201-180954-0009J'
    @user.click_button 'Change Identity Card Number'
    expect(@user.response).to contain('201-180954-0009J')
  end

end
