require 'spec_helper'

describe Article do

  describe "relationship" do
    it {should belong_to(:user)}
  end

  describe "mass assignment" do
    it {should allow_mass_assignment_of(:title)}
    it {should allow_mass_assignment_of(:teaser)}
    it {should allow_mass_assignment_of(:body)}
    it {should allow_mass_assignment_of(:version)}
    it {should allow_mass_assignment_of(:changelog)}

    it {should_not allow_mass_assignment_of(:user_id)}
  end

  describe "default values" do
    describe "#state" do
      it "be 0" do
        Article.new.state.should == 0
      end
    end
  end

  describe "validation" do
    it {should validate_presence_of(:title)}
    it {should ensure_length_of(:title).is_at_most(80)}
    it {should validate_presence_of(:teaser)}
    it {should ensure_length_of(:teaser).is_at_most(500)}
    it {should validate_presence_of(:body)}
    it {should ensure_length_of(:version).is_at_most(120)}
    it {should ensure_length_of(:changelog).is_at_most(2000)}
    it {should ensure_length_of(:message).is_at_most(5000)}
    it {should validate_presence_of(:state)}
    it {should validate_numericality_of(:state)}
    it {should ensure_inclusion_of(:state).in_range(0..4)}
  end
end
