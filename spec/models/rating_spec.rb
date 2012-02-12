require 'spec_helper'

describe Rating do
  describe "ralationship" do
    it {should belong_to :user}
    it {should belong_to :article}
  end

  describe "mass assignment" do
    it {should allow_mass_assignment_of :stars}
    it {should_not allow_mass_assignment_of :user_id}
    it {should_not allow_mass_assignment_of :article_id}
  end

  describe "validation" do
    it {should validate_presence_of :user}
    it {should validate_presence_of :article}
    it {should validate_presence_of :stars}
    it {should ensure_inclusion_of(:stars).in_range(Rating::STARS)}
  end
end
