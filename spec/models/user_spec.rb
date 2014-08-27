require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do

    describe :id_number do

      it 'has an id_number attribute' do
        user = User.new(:id_number => 'ABCD1234xyz')
        expect(user.id_number).to eq('ABCD1234xyz')
      end

      it 'can be set' do
         user = User.new
         user.id_number = 'ABCD1234xyz'
         expect(user.id_number).to eq('ABCD1234xyz')
      end

    end

end
