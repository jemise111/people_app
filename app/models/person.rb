class Person < ActiveRecord::Base

  def name
    "#{first_name} #{last_name}"
  end

  def birthday
    birthdate.strftime("%D")
  end

  def have_a_drink
    if legal?
      drunk? ? "Go home you're drunk" : self.drinks += 1
    else
      'Wait a few years'
    end
  end

  def drive_a_car
    if drunk?
      'Looks like a cab for you tonight'
    end
  end

  def sober_up
    self.drinks -= 1 unless drinks.zero?
  end

  private

  def age
    # does not account for leap years
    (self.birthdate - DateTime.now).abs / (365 * 24 * 60 * 60)
  end

  def drunk?
    drinks >= 3
  end

  def legal?
    age >= 21
  end
end
