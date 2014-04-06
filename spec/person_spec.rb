require 'spec_helper'

describe Person do
  subject(:jesse) { Person.create(first_name: "Jesse",
                                   last_name: "Sessler",
                                   image_url: "http://stockstoblocks.com/wp-content/uploads/2013/11/blogpic2.jpg",
                                   birthdate: DateTime.now - (21 * 365),
                                   license: true,
                                   drinks: 0) }
  describe "#name" do
    it "should return a string that is the object's full name" do
      expect(jesse.name).to eq('Jesse Sessler')
    end
  end
  describe "#birthday" do
    it "should return a string that is the object's birthday" do
      result = (DateTime.now - (21 * 365)).strftime("%D")
      expect(jesse.birthday).to eq(result)
    end
  end
  context "person is over 21" do
    describe "#have_a_drink" do
      it "should increase a persons drinks by 1" do
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
        jesse.update(drinks: 3)
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
        jesse.sober_up
        expect(jesse.drinks).to eq(0)
      end
    end
  end
  context "person is under 21 but over 18" do
    before(:each) { jesse.update(birthdate: DateTime.now - (19 * 365)) }
    describe "#have_a_drink" do
      it "should return wait string" do
        jesse.have_a_drink
        expect(jesse.have_a_drink).to eq('Wait a few years')
        expect(jesse.drinks).to eq(0)
      end
    end
    describe "#drive_a_car" do
      it "should return true if person has a license, false otherwise" do
        expect(jesse.drive_a_car).to eq(true)
        jesse.update(license: false)
        expect(jesse.drive_a_car).to eq(false)
      end
    end
  end
  context "person is under 18" do
    describe "#drive_a_car" do
      it "should return youngin string" do
        jesse.update(birthdate: DateTime.now - (17 * 365))
        expect(jesse.drive_a_car).to eq("Not yet youngin")
      end
    end
  end
end
