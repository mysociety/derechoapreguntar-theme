require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe InfoRequest do


    describe :enumerate_states do

        it 'should include "deadline_extended"' do
            InfoRequest.enumerate_states.include?('deadline_extended').should be_true
        end

    end

    describe :get_status_description do

        it 'should return "Deadline extended." for status "deadline_extended"' do
            InfoRequest.get_status_description('deadline_extended').should == 'Deadline extended.'
        end

    end

end
