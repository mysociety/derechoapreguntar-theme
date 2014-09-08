class GeneralLaw < ActiveRecord::Base
  validates :date_of_birth,
            :presence => { :message => _('Please enter your date of birth') }

  validates :marital_status,
            :presence => { :message => _('Please enter your marital status') }

  validates :occupation,
            :presence => { :message => _('Please enter your occupation') }

  validates :domicile,
            :presence => { :message => _('Please enter your domicile') }
end
