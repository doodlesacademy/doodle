class Donor < ActiveRecord::Base
  def name
    "#{first_name} #{last_name}"
  end
end
