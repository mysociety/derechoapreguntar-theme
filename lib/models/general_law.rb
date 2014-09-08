class GeneralLaw < ActiveRecord::Base
  validates :date_of_birth,
            :presence => { :message => _('Please enter your date of birth') }

  validates :marital_status,
            :presence => { :message => _('Please enter your marital status') }

  validates :occupation,
            :presence => { :message => _('Please enter your occupation') }

  validates :domicile,
            :presence => { :message => _('Please enter your domicile') }

  validate :date_of_birth_in_past

  private

  def date_of_birth_in_past
    if date_of_birth && date_of_birth > Date.today
      errors.add(:date_of_birth, _('Please enter a valid date of birth'))
    end
  end

end
