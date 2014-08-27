require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do

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

end
