require 'spec_helper'

describe User do

  describe "relationship" do
    it {should have_many(:articles)}
  end

  describe "mass assignment" do
    it {should allow_mass_assignment_of(:email)}
    it {should allow_mass_assignment_of(:password)}
    it {should allow_mass_assignment_of(:password_confirmation)}
    it {should allow_mass_assignment_of(:remember_me)}
    it {should allow_mass_assignment_of(:fullname)}
    it {should allow_mass_assignment_of(:shortbio)}
    it {should allow_mass_assignment_of(:weburl)}

    it { should_not allow_mass_assignment_of(:encrypted_passord) }
  end

  context "with valid attributes" do
    user = User.make
    specify {user.should be_valid}
  end

  context "validation" do
    it "should deny invalid email" do
      user = User.make :email => "invalid_email"
      user.should_not be_valid
      user.should have(1).error_on(:email)
      user.errors[:email].should == ["is invalid"]
      # user.errors[:email].should_not be_empty
    end

    it {should ensure_length_of(:password).is_at_least(6)}
  end
end
