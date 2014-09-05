require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserController do

  before do
    # Don't call out to external url during tests
    controller.stub!(:country_from_ip).and_return('gb')
  end

  describe :signup do

    it 'requires the user to accept the terms and conditions' do
      post :signup, :user_signup => { :email => 'new@localhost',
                                      :name => 'New Person',
                                      :password => 'sillypassword',
                                      :password_confirmation => 'sillypassword',
                                      :identity_card_number => '201-180954-0009J',
                                      :terms => '0' }

      expect(response).to render_template('sign')
    end

    it 'registers the user if they accept the terms and conditions' do
      post :signup, :user_signup => { :email => 'new@localhost',
                                      :name => 'New Person',
                                      :password => 'sillypassword',
                                      :password_confirmation => 'sillypassword',
                                      :identity_card_number => '201-180954-0009J',
                                      :terms => '1' }

      expect(User.where(:email => 'new@localhost')).to have(1).item
    end

  end

end
