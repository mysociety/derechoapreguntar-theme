require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do

    describe :terms do

      before(:each) do
        @user_attrs = { :name => 'Rob Smith',
                        :email => 'rob@localhost',
                        :password => 'insecurepassword',
                        :identity_card_number => '201-180954-0009J' }
      end

      it 'requires the terms to be accepted to be valid' do
        user = User.new(@user_attrs.merge({ :terms => '0' }))
        expect(user).to_not be_valid
      end

      it 'is valid if the terms are accepted' do
        user = User.new(@user_attrs.merge({ :terms => '1' }))
        expect(user).to be_valid
      end

    end

    describe :identity_card_number do

      it 'has an identity_card_number attribute' do
        user = User.new(:identity_card_number => 'ABCD1234xyz')
        expect(user.identity_card_number).to eq('ABCD1234xyz')
      end

      it 'can be set' do
         user = User.new
         user.identity_card_number = 'ABCD1234xyz'
         expect(user.identity_card_number).to eq('ABCD1234xyz')
      end

      it 'is not valid if no identity_card_number is present' do
        expect(User.new).to have(1).error_on(:identity_card_number)
      end

    end

    describe 'updating identity_card_number' do

      before(:each) do
        user_attrs = { :name => 'Rob Smith',
                       :email => 'rob@localhost',
                       :password => 'insecurepassword',
                       :identity_card_number => 'BOB10341' }
        @user = User.new(user_attrs)
        @user.save
      end

      it "creates a censor rule for the user's identity card number" do
        expect(@user.censor_rules.where(:text => 'BOB10341')).to have(1).item
      end

      it 'creates another censor rule when the user changes identity card number' do
        @user.update_attribute(:identity_card_number, 'BOB-10341')
        expect(@user.censor_rules.where(:text => 'BOB10341')).to have(1).item
        expect(@user.censor_rules.where(:text => 'BOB-10341')).to have(1).item
      end

      it 'does not duplicate censor rules' do
        @user.update_attribute(:identity_card_number, @user.identity_card_number)
        expect(@user.censor_rules.where(:text => 'BOB10341')).to have(1).item
      end

      it 'creates the censor rule with a replacement message' do
        expect(@user.censor_rules.last.replacement).to eql('REDACTED')
      end

      it 'creates the censor rule with the THEME_NAME as the author' do
        expect(@user.censor_rules.last.last_edit_editor).to eql(THEME_NAME)
      end

      it 'creates the censor rule with a generic comment' do
        comment = 'Updated automatically after_save'
        expect(@user.censor_rules.last.last_edit_comment).to eql(comment)
      end

    end

end
