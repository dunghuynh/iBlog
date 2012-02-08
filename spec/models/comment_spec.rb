require 'spec_helper'

describe Comment do
  describe 'relationship' do
    it {should belong_to(:user)}
    it {should belong_to(:article)}
  end

  describe 'mass assignment' do
    it {should allow_mass_assignment_of(:body)}
  end

  describe 'validation' do
    it {should validate_presence_of(:user)}
    it {should validate_presence_of(:article)}
    it {should validate_presence_of(:body)}
    it {should ensure_length_of(:body).is_at_most(50000)}
  end
end
