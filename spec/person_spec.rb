require 'spec_helper'

describe Person do
  subject(:jesse) { Person.create(first_name: "Jesse",
                                   last_name: "Sessler",
                                   image_url: "http://stockstoblocks.com/wp-content/uploads/2013/11/blogpic2.jpg") }
  describe "#name" do
    it "should return a string that is the object's full name" do
      expect(jesse.name).to eq('Jesse Sessler')
    end
  end
  describe "#birthday" do
    it "should return a string that is the object's birthday" do
      jesse.update(birthdate: '1990-01-11')
      expect(jesse.birthdate).to eq(Date.new('1990-01-11'))
    end
  end
  context "person is over 21" do
    before(:all) { jesse.birthdate('1993-04-01') }
    describe "#have_a_drink" do
      it "should increase a persons drinks by 1" do
        jesse.update(drinks: 0)
        jesse.have_a_drink
        expect(jesse.drinks).to eq(1)
      end
      it "should return drunk string and not increase a persons drink by 1 if they've had 3 drinks" do
        jesse.update(drinks: 2)
        jesse.have_a_drink
        expect(jesse.drinks).to eq(3)
        jesse.update(drinks: 3)
        expect(jesse.have_a_drink).to eq("Go home you're drunk")
        expect(jesse.drinks).to eq(3)
      end
    end
  end
  context "person is under 21 but over 18" do
    before(:all) { jesse.birthdate('1994-04-01') }
    describe "#have_a_drink" do
      it "should return wait string" do
        jesse.update(drinks: 0)
        jesse.have_a_drink
        expect(jesse.have_a_drink).to eq('Wait a few years')
        expect(jesse.drinks).to eq(0)
      end
    end
    describe "#drive_a_car" do
      it "should return true if person has a license, false otherwise" do
        jesse.update(license: true)
        expect(jesse.drive_a_car).to be_true
        jesse.update(license: false)
        expect(jesse.drive_a_car).to be_false
      end
    end
  end
end

#name
should return a string that is the object's full name
#birthday

#have_a_drink
if they are over 21 then they can drink and the number stored in the drinks attribute is increased by 1
if they are under 21 then the string "Wait a few years" is returned
if they can drink, they are not allowed to have more than three drinks otherwise the string "Go home you're drunk"
#drive_a_car
if they are under 18 then a string "Not yet youngin" is returned
if they are 18 and they have a license then they can drive
if they are over 18 and have a license then they can drive
if they are over 21, have a license, and are drunk then the string "Looks like a cab for you tonight" is returned
#sober_up
if they have any drinks, it decreases it by 1
if they have no drinks, nothing happens
