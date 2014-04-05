class Person < ActiveRecord::Base

  def name
    "#{first_name} #{last_name}"
  end

  def birthday
    birthdate.strftime("%D")
  end

  def have_a_drink
    self.drinks += 1 if age >= 21
  end


  private

  def age
    # does not account for leap years
    (self.birthdate - DateTime.now).abs / (365 * 24 * 60 * 60)
  end
end
