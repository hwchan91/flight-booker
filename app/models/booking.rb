class Booking < ApplicationRecord
  after_validation :after_validation

  belongs_to :flight
  has_many :passengers, dependent: :destroy
  accepts_nested_attributes_for :passengers
  validates_associated :passengers

  def after_validation
    # Skip errors that won't be useful to the end user
    filtered_errors = self.errors.reject{ |err| err.include?("is invalid")}

    # recollect the field names and retitlize them
    # this was I won't be getting 'user.person.first_name' and instead I'll get
    # 'First name'
    filtered_errors.collect{ |err|
      if err[0] =~ /(.+\.)?(.+)$/
        err[0] = $2.titleize
      end
      err
    }

    # reset the errors collection and repopulate it with the filtered errors.
    self.errors.clear
    filtered_errors.each { |err| self.errors.add(*err) }
  end

end
