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
      expect(jesse.birthday).to eq('01/11/90')
    end
  end
  context "person is over 21" do
    before(:each) { jesse.update(birthdate: '1993-04-01') }
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
    describe "#drive_a_car" do
      it "should return cab string if person has had at least 3 drinks" do
        jesse.update(license: true, drinks: 3)
        expect(jesse.drive_a_car).to eq("Looks like a cab for you tonight")
      end
    end
    describe "#sober_up" do
      it "should decrease drinks by one if person has had drinks" do
        jesse.update(drinks: 2)
        jesse.sober_up
        expect(jesse.drinks).to eq(1)
      end
      it "should do nothing if person has not had drinks" do
        jesse.update(drinks: 0)
        jesse.sober_up
        expect(jesse.drinks).to eq(0)
      end
    end
  end
  context "person is under 21 but over 18" do
    before(:each) { jesse.update(birthdate: '1994-04-01') }
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
        expect(jesse.drive_a_car).to eq(true)
        jesse.update(license: false)
        expect(jesse.drive_a_car).to eq(false)
      end
    end
  end
  context "person is under 18" do
    describe "#drive_a_car" do
      it "should return youngin string" do
        expect(jesse.drive_a_car).to eq("Not yet youngin")
      end
    end
  end
end
