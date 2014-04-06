class Person < ActiveRecord::Base

  def name
    "#{first_name} #{last_name}"
  end

  def birthday
    birthdate.strftime("%D")
  end

  def have_a_drink
    if age >= 21
      drunk ? "Go home you're drunk" : self.drinks += 1
    end
  end

  def drive_a_car
    if drunk
      'Looks like a cab for you tonight'
    end
  end

  private

  def age
    # does not account for leap years
    (self.birthdate - DateTime.now).abs / (365 * 24 * 60 * 60)
  end

  def drunk
    drinks >= 3
  end
end
