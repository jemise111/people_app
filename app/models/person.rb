class Person < ActiveRecord::Base
  HOURS_IN_YEAR = 17 * 365 * 24 * 60 * 60 # doesn't account leap year

  def name
    "#{first_name} #{last_name}"
  end

  def birthday
    birthdate.strftime("%D")
  end

  def have_a_drink
    if legal_for_drinking?
      drunk? ? "Go home you're drunk" : self.drinks += 1
    else
      'Wait a few years'
    end
  end

  def drive_a_car
    if drunk?
      'Looks like a cab for you tonight'
    else
      legal_for_driving? ? license : 'Not yet youngin'
    end
  end

  def sober_up
    self.drinks -= 1 unless drinks.zero?
  end

  private

  def age
    # does not account for leap years
    (birthdate - DateTime.now).abs / (365 * 24 * 60 * 60)
  end

  def drunk?
    drinks >= 3
  end

  def legal_for_drinking?
    age >= 21
  end

  def legal_for_driving?
    age >= 18
  end
end
